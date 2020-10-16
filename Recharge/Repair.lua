local Recharge = Recharge

local function IsItemAboveConditionThreshold(bagId,slotIndex,minPercent)
	local condition = GetItemCondition(bagId,slotIndex)
	return (condition / 100) > minPercent,condition
end

local function println(...)
	local args = {...}
	for i,v in ipairs(args) do
		args[i] = tostring(v)
	end 
	table.insert(args,1,_prefix)
	d(table.concat(args))
end


local function RepairItem(bagId,slotIndex,kits,minPercent)
    --Do we have any repair kits?
	local count = #kits 
	if count < 1 then return 0 end
	--Is the item's condition below the set threshold?
	local isAbove,condition = IsItemAboveConditionThreshold(bagId,slotIndex,minPercent)
	if isAbove == true then return 0 end
    --item can be repaired, so find a kit now!
    local amount = 0
    local kitsIndex = #kits or 0
    local foundKit = false

	-- Use item level appropriate repair kit?
	if Recharge.settings.useRepairKitForItemLevel then
        --Get the item's link
        local link = GetItemLink(bagId,slotIndex,LINK_STYLE_DEFAULT)
        if link ~= nil then
            --Get the item's level
            local level = GetItemLinkRequiredLevel(link)
            --Find a kit can do more than 90% repair -> Code by ESOUI.com user "simonhang"!
            while(kitsIndex > 0 and foundKit == false)
            do
                local kit = kits[kitsIndex]
                --println("item level:"..tostring(level).." kit tier:"..tostring(kit.tier))
                amount = GetAmountRepairKitWouldRepairItem(bagId,slotIndex,kit.bag,kit.index)
                if (kit.tier == math.floor(level/10)+1) and amount > 10 then
                    --Repair kit that would repair 90% was found
                    --It's given via the index kitsIndex!
                    foundKit = true
                else
                    kitsIndex = kitsIndex - 1
                end
            end
            --No kit that meets the requirements was found yet?
            if kitsIndex <= 0 and foundKit == false then
                --So use one of the other kits as fallback!
                kitsIndex = #kits or 0
                foundKit = true
            end
        end
    else
        foundKit = true -- Just tell the addon to go on by setting this variable to true
	end -- Use item level appropriate repair kit

    --Was a kit found that should be used?
	if foundKit == true and kitsIndex > 0 then
        --Get the repair kit by it's index (either the last one in the table,
        -- or the determined one for the current item's level, that needs to be repaired)
		local kit = kits[kitsIndex]
        if kit ~= nil then
            -- Use not the item level appropriate repair kit?
            -- We neef to get the repair amount that the kit will do etc. then
            -- If the setting is enabled the amount was determined above already!
            if not Recharge.settings.useRepairKitForItemLevel then
                amount = GetAmountRepairKitWouldRepairItem(bagId,slotIndex,kit.bag,kit.index)
            end
            local oldcondition = condition
            --Repair the item with the repair kit now
            RepairItemWithRepairKit(bagId,slotIndex,kit.bag,kit.index)
            --Reduce the repair kits stacksize by 1
            kit.size = kit.size - 1
            --If no kits are left int eh stack, renmove the stack from the total kits table
            if kit.size < 1 then
                table.remove(kits, kitsIndex)
            end
            --Calculate the new item condition by adding the amount the repair kit repaired it
            condition = condition + amount
            --Maximize the condition to 100%
            if condition > 100 then
                condition = 100
            end
            --Return the difference the repair kit repaired!
            return (condition-oldcondition)
        end
	end

	return 0
end 

local r = {}

r.RepairItem = RepairItem

Recharge.Repair = r
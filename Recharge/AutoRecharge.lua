local addonName = "Auto%sRecharge"
Recharge = {
	version				= "2.72",
    author				= "XanDDemoX, current: Baertram",
    name				= string.format(addonName, " "),
    displayName			= string.format(addonName, " "),
	eventName			= string.format(addonName, "_"),
    website				= "http://www.esoui.com/downloads/info1091-AutoRecharge.html#info",
	savedVarsName		= "AutoRecharge_SavedVariables",
    savedVarsVersion	= 2.1, --Changing this will reset all SavedVariables!
}
local Recharge = Recharge

Recharge.preChatTextRed = "|cDD2222AutoRecharge|r "
local eventName = Recharge.eventName
local eventSuffixCharge = "_INV_UPDATE_CHARGE"
local eventSuffixRepair = "_INV_UPDATE_REPAIR"

local PLAYER = "player"
local REPAIR
local CHARGE
local RECHARGE_BAG

Recharge._isPlayerCurrentlyDead = false
local isPlayerCurrentlyDead = Recharge._isPlayerCurrentlyDead
Recharge._isRepairCurrentlyActive = false
local isRepairCurrentlyActive = Recharge._isRepairCurrentlyActive

Recharge.noChargeChangeEvents = {}
Recharge.noDurabilityChangeEvents = {}

local _repairSlots		= {EQUIP_SLOT_OFF_HAND,EQUIP_SLOT_BACKUP_OFF, EQUIP_SLOT_HEAD, EQUIP_SLOT_SHOULDERS, EQUIP_SLOT_CHEST,EQUIP_SLOT_WAIST, EQUIP_SLOT_LEGS,EQUIP_SLOT_HAND, EQUIP_SLOT_FEET}
local _rechargeSlots	= {EQUIP_SLOT_MAIN_HAND,EQUIP_SLOT_OFF_HAND,EQUIP_SLOT_BACKUP_MAIN,EQUIP_SLOT_BACKUP_OFF}

local _slotText = {
--[[
	[EQUIP_SLOT_MAIN_HAND] 		= GetString(SI_EQUIPTYPE14),
	[EQUIP_SLOT_OFF_HAND] 		= GetString(SI_EQUIPTYPE7),
	[EQUIP_SLOT_BACKUP_MAIN] 	= GetString(SI_EQUIPSLOT20),
	[EQUIP_SLOT_BACKUP_OFF] 	= GetString(SI_EQUIPSLOT21),
	[EQUIP_SLOT_HEAD] 			= GetString(SI_EQUIPTYPE1),
	[EQUIP_SLOT_SHOULDERS] 		= GetString(SI_EQUIPTYPE4),
	[EQUIP_SLOT_CHEST] 			= GetString(SI_EQUIPTYPE3),
	[EQUIP_SLOT_WAIST] 			= GetString(SI_EQUIPTYPE8),
	[EQUIP_SLOT_LEGS] 			= GetString(SI_EQUIPTYPE9),
	[EQUIP_SLOT_HAND] 			= GetString(SI_EQUIPTYPE13),
	[EQUIP_SLOT_FEET] 			= GetString(SI_EQUIPTYPE10)
]]
	[EQUIP_SLOT_MAIN_HAND] 		= GetString(SI_EQUIPTYPE14),
	[EQUIP_SLOT_OFF_HAND] 		= GetString(SI_EQUIPTYPE7),
	[EQUIP_SLOT_BACKUP_MAIN] 	= GetString(SI_EQUIPSLOT20),
	[EQUIP_SLOT_BACKUP_OFF] 	= GetString(SI_EQUIPSLOT21),
	[EQUIP_SLOT_HEAD] 			= GetString(SI_EQUIPTYPE1),
	[EQUIP_SLOT_SHOULDERS] 		= GetString(SI_EQUIPTYPE4),
	[EQUIP_SLOT_CHEST] 			= GetString(SI_EQUIPTYPE3),
	[EQUIP_SLOT_WAIST] 			= GetString(SI_EQUIPTYPE8),
	[EQUIP_SLOT_LEGS] 			= GetString(SI_EQUIPTYPE9),
	[EQUIP_SLOT_HAND] 			= GetString(SI_EQUIPTYPE13),
	[EQUIP_SLOT_FEET] 			= GetString(SI_EQUIPTYPE10)
 }

local _prefix = "|c22DD22[AutoRecharge]|r "
Recharge.defaultSettings = {
	AccountWide							= false,
	chargeEnabled						= true,
	rechargeDelay						= 500,
	chargeDuringCombat					= false,
    minChargePercent					= 0,
    alertSoulGemsEmpty					= false,
    alertSoulGemsSoonEmpty				= false,
    alertSoulGemsSoonEmptyThreshold		= 20,
    alertSoulGemsEmptyOnLogin			= true,
	chargeOnWeaponChange				= false,
	chargeOnWeaponChangeOnlyInCombat	= true,

	repairEnabled						= true,
	repairDelay							= 500,
	repairDuringCombat					= false,
    minConditionPercent					= 0,
    alertRepairKitsEmpty				= false,
    alertRepairKitsSoonEmpty			= false,
    alertRepairKitsSoonEmptyThreshold	= 10,
    alertRepairKitsEmptyOnLogin			= true,

    showRepairKitsLeftAtVendor			= false,
    useRepairKitForItemLevel            = false,

	dontUseCrownRepairKits				= false,

    chatOutput							= true,
    chatOutputSuppressNothingMessages	= true,
}

local function println(...)
	local args = {...}
	for i,v in ipairs(args) do
		args[i] = tostring(v)
	end
	table.insert(args,1,_prefix)
	d(table.concat(args))
end
Recharge.Println = println

local function round(value,places)
	local s =  10 ^ places
	return math.floor(value * s + 0.5) / s
end

local function trim(str)
	if str == nil or str == "" then return str end 
	return (str:gsub("^%s*(.-)%s*$", "%1"))
end 

local function ARC_GetEquipSlotText(slot)
	return _slotText[slot]
end

local function ARC_IsPlayerDead(forceUpdate)
	forceUpdate = forceUpdate or false
	if isPlayerCurrentlyDead == nil or forceUpdate == true then isPlayerCurrentlyDead = IsUnitDead(PLAYER) end
	--Fix for IsUnitDead("player") which maybe return false if directly called after/before player dead where the
	--durability of items change but player is not dead yet.
	local myCurrentPlayerHealth
	local wasDead = isPlayerCurrentlyDead
	if not isPlayerCurrentlyDead then
		myCurrentPlayerHealth = 0
		--Check the health of the player, if <= 0 then "player is dead"
		myCurrentPlayerHealth, _, _ = GetUnitPower(PLAYER, COMBAT_MECHANIC_FLAGS_HEALTH)
		if myCurrentPlayerHealth <= 0 then isPlayerCurrentlyDead = true end
	end
d("[ARC]ARC_IsPlayerDead: " .. tostring(isPlayerCurrentlyDead) .. ", playerHealth: " ..tostring(myCurrentPlayerHealth) .. ", wasDead: " ..tostring(wasDead))
	return isPlayerCurrentlyDead
end
Recharge.IsPlayerDead = ARC_IsPlayerDead

--Check if we are in combat and if the setting disallows to proceed then,
--or if we are not in combat it will be allowed to proceed.
--returns true if allowed to proceed, false if not allowed
local function duringCombatCheck(repairOrRechargeDuringCombatSetting, inCombat)
	if inCombat == nil then inCombat = IsUnitInCombat(PLAYER) end
	if inCombat == true and repairOrRechargeDuringCombatSetting ~= nil then
		return repairOrRechargeDuringCombatSetting
	end
	return true
end

--Check if the BagId is the one of BAG_WORN (worn items), if the player is not currently dead,
--and if the "during combat" checks allow to proceed.
--returns true if allowed to proceed, false if not allowed
local function wornNotDeadAndNotInCombatChecks(bagId, repairOrRechargeDuringCombatSetting)
	if bagId ~= BAG_WORN or ARC_IsPlayerDead() == true or
			duringCombatCheck(repairOrRechargeDuringCombatSetting, nil) == false then
d("<<<<noWornNoDeadNoDuringCombatCheck - NOT allowed!")
		return false
	end
d("<<<<noWornNoDeadNoDuringCombatCheck - allowed")
	return true
end

local function ARC_showAlertMessage(alertType, value)
	if not alertType then return false end
    local alertMsg
    local iconText
    if alertType == "repairKitsEmpty" then
    	alertMsg = GetString(ARC_ALERT_REPAIRKITS_EMPTY)
        iconText = zo_iconTextFormat("esoui/art/icons/quest_crate_001.dds", 48, 48, " ")
    elseif alertType == "repairKitsSoonEmpty" then
    	if not value then return end
    	alertMsg = zo_strformat(GetString(ARC_ALERT_REPAIRKITS_SOON_EMPTY), value)
        iconText = zo_iconTextFormat("esoui/art/icons/quest_crate_001.dds", 48, 48, " ")
    elseif alertType == "soulGemsEmpty" then
    	alertMsg = GetString(ARC_ALERT_SOULGEMS_EMPTY)
        iconText = zo_iconTextFormat("esoui/art/icons/soulgem_006_empty.dds", 48, 48, " ")
    elseif alertType == "soulGemsSoonEmpty" then
    	if not value then return end
    	alertMsg = zo_strformat(GetString(ARC_ALERT_SOULGEMS_SOON_EMPTY), value)
        iconText = zo_iconTextFormat("esoui/art/icons/soulgem_006_empty.dds", 48, 48, " ")
    end
    if alertMsg and alertMsg ~= "" then
		CENTER_SCREEN_ANNOUNCE:AddMessage(EVENT_SKILL_RANK_UPDATE, CSA_EVENT_SMALL_TEXT, nil, iconText .. Recharge.preChatTextRed .. alertMsg)
    end
end

local function ARC_checkThresholdOrEmpty(checkType, emptyOrThreshold, amount)
	if checkType == nil then return false end
    if emptyOrThreshold == nil then return false end
    if amount == nil then return false end
	local settings = Recharge.settings

    if 		checkType == "repairKits" then
    	if emptyOrThreshold then
            if amount == 0 then
	        	ARC_showAlertMessage("repairKitsEmpty")
            end
        else
			if amount < settings.alertRepairKitsSoonEmptyThreshold then
                ARC_showAlertMessage("repairKitsSoonEmpty", amount)
            end
        end
    elseif 	checkType == "soulGems" then
    	if emptyOrThreshold then
            if amount == 0 then
                ARC_showAlertMessage("soulGemsEmpty")
            end
        else
			if amount < settings.alertSoulGemsSoonEmptyThreshold then
                ARC_showAlertMessage("soulGemsSoonEmpty", amount)
            end
        end
    end
end

local function ARC_GetSoulGemsCount()
    --Get the actual soul gems amount
    RECHARGE_BAG = RECHARGE_BAG or Recharge.Bag
    local gems = RECHARGE_BAG.GetSoulGems(BAG_BACKPACK)
    local gemsCount = #gems
    if gemsCount > 0 then
        gemsCount = 0
        for _, soulGemStack in pairs(gems) do
            gemsCount = gemsCount + soulGemStack.size
        end
    end
    return gemsCount, gems
end
--Recharge.GetSoulGemsCount = ARC_GetSoulGemsCount

local function ARC_GetRepairKitsCount()
    --Get the actual repair kits amount
    RECHARGE_BAG = RECHARGE_BAG or Recharge.Bag
	local kits = RECHARGE_BAG.GetRepairKits(BAG_BACKPACK)
	Recharge.kitsInInventoryBag = kits
    local kitsCount = #kits or 0
    if kitsCount > 0 then
        kitsCount = 0
        for _, repairKitsStack in pairs(kits) do
            kitsCount = kitsCount + repairKitsStack.size
        end
    end
    return kitsCount, kits
end
--Recharge.GetRepairKitsCount = ARC_GetRepairKitsCount

local function ARC_ChargeEquipped(chatOutput, inCombat, slotIndex)
	CHARGE = CHARGE or Recharge.Charge

	chatOutput = chatOutput or false
	local settings = Recharge.settings
	local abortedDueToDeath = ARC_IsPlayerDead()
	--Do not go on if the player is dead
	if abortedDueToDeath then return end

	local gemsCount, gems = ARC_GetSoulGemsCount()
	if gemsCount == 0 then
		if chatOutput and settings.alertSoulGemsEmpty  and not settings.chatOutputSuppressNothingMessages then
			println(GetString(ARC_ALERT_SOULGEMS_EMPTY))
		end
		if not inCombat and settings.alertSoulGemsEmpty then
            ARC_checkThresholdOrEmpty("soulGems", true, gemsCount)
        end
		return
	end

	local total = 0
	local str

	for i, slot in ipairs(_rechargeSlots) do
		if HasItemInSlot(BAG_WORN, slot) then
			if slotIndex == nil or (slotIndex ~= nil and slotIndex == slot) then
				total, abortedDueToDeath = CHARGE.ChargeItem(BAG_WORN, slot, gems, settings.minChargePercent)
				if abortedDueToDeath == false and total > 0 and chatOutput then
					str = (str or GetString(ARC_CHATOUTPUT_CHARGED))..((str and ", ") or "")..ARC_GetEquipSlotText(slot).." ("..tostring(round(total,2)).." %)"
				end
				if abortedDueToDeath then return end
				--Slot to check was found, abort other slot checks
				if slotIndex ~= nil then break end
			end
		end
	end

	if str == nil and chatOutput and not settings.chatOutputSuppressNothingMessages then
		local charge,maxcharge
		for i,slot in ipairs(_rechargeSlots) do
			if HasItemInSlot(BAG_WORN, slot) then
				if slotIndex == nil or (slotIndex ~= nil and slotIndex == slot) then
					charge, maxcharge = GetChargeInfoForItem(BAG_WORN,slot)
					if maxcharge > 0 then
						str = (str or GetString(ARC_CHATOUTPUT_CHARGED_NOTHING))..((str and ", ") or "")..ARC_GetEquipSlotText(slot).." ("..tostring(round((charge / maxcharge) * 100,2)).." %)"
					end
					--Slot to check was found, abort other slot checks
					if slotIndex ~= nil then break end
				end
			end
		end
	end

	if str ~= nil and chatOutput then
		println(str)
	elseif str == nil and chatOutput and not settings.chatOutputSuppressNothingMessages then
		println(GetString(ARC_CHATOUPUT_NO_CHARGEABLE_WEAPONS))
	end

	if not inCombat and settings.alertSoulGemsSoonEmpty then
        ARC_checkThresholdOrEmpty("soulGems", false, gemsCount)
	end
end

local function resetRepair()
	isRepairCurrentlyActive = false
	return
end

--Repair the equipped item with the slotIndex. If slotIndex is nil: Repair all equipped items
local function ARC_RepairEquipped(chatOutput, inCombat, slotIndex)
	REPAIR = REPAIR or Recharge.Repair
	chatOutput = chatOutput or false

	--Is the Player dead?
	local abortedDueToDeath = ARC_IsPlayerDead()
d("[Recharge]RepairEquipped - isDead: " ..tostring(abortedDueToDeath) .. ", repairActive: " ..tostring(isRepairCurrentlyActive)  .. ", inCombat: " ..tostring(inCombat) ..", slotIndex: " ..tostring(slotIndex) ..", chatOutput: " ..tostring(chatOutput))
	--Do not go on if the player is dead
	if abortedDueToDeath then
d("<<ABORT - player is dead")
		return resetRepair()
	end

	--Prevent multiple repair runs at the same time!
	if isRepairCurrentlyActive == true then
d("<<ABORT - Repair run is active")
		return
	end
	isRepairCurrentlyActive = true

	local settings = Recharge.settings

	--Get the repair kits and their count
	local kitsCount, kits = ARC_GetRepairKitsCount()
	if kitsCount == 0 then
		if settings.alertRepairKitsEmpty then
			if chatOutput and not settings.chatOutputSuppressNothingMessages then
				println(GetString(ARC_ALERT_REPAIRKITS_EMPTY))
			end
			if not inCombat then
				ARC_checkThresholdOrEmpty("repairKits", true, kitsCount)
			end
		end
d("<<ABORT - Kits count is 0")
		return resetRepair()
	end

	--Check each equipped item if it needs to be repaired
	--and output it's repaired condition to the chat (if enabled)
	--Delay each repair attempt by the settings chosen "delay between repair"
	-->If chat output is enabled the output will be delayed by the total delay needed to repair all + 25 milliseconds
	-->If a repair attempt is currently done (even if delayed) further more repair attempts are suppressed
	local total = 0
	local wasCrownRepairKitUsed = false
	local kitWasUsed            = false
	local newCondition = 0
	local chatOutputStr

	local minConditionPercent = settings.minConditionPercent

	--Currently not used as total functions need to be rewritten to support delays and
	--death checks with delay
	local delayBetweenRepair = settings.repairDelay
	local checkNextSlotDelay = 0
	local totalDelay = 0

	for _, slot in ipairs(_repairSlots) do
		--Only go on if no crown repair kit has repaired all already
		if not wasCrownRepairKitUsed and not abortedDueToDeath then
			if (slotIndex == nil or (slotIndex ~= nil and slotIndex == slot)) then
				--Check if the slot is equipped
				if HasItemInSlot(BAG_WORN, slot) then
					--First slot to check?
					if checkNextSlotDelay == 0 then

d(">> ???????????????????????????????????????")
d(">>Repair check slot no delay: " ..tostring(slot) .. " - " .. GetItemLink(BAG_WORN, slot))
						if not wasCrownRepairKitUsed and not abortedDueToDeath then
							--Prevent the repair try if a crown store repair kit was used already
							total, wasCrownRepairKitUsed, kitWasUsed, abortedDueToDeath, newCondition = REPAIR.RepairItem(BAG_WORN, slot, kits, minConditionPercent)
							--A repair kit was used?
							if not abortedDueToDeath and kitWasUsed then
								--Update the crown repair kit used flag
								if wasCrownRepairKitUsed then
d("<<break loop -> Crown repair kit used")
									totalDelay = 0
									break --leave the loop
								end
							elseif abortedDueToDeath then
d("<<break loop -> Dead")
								totalDelay = 0
								break --leave the loop
							end

							--Chat output needed? Append the output string, but only if no crown repair kit was used.
							-->Chat output text for crown repair kit usage will be done further down below
							if not abortedDueToDeath and chatOutput and not wasCrownRepairKitUsed and total > 0 and kitWasUsed then
								chatOutputStr = (chatOutputStr or GetString(ARC_CHATOUTPUT_REPAIRED))..((chatOutputStr and ", ") or "")..ARC_GetEquipSlotText(slot).." (+"..tostring(round(total,2)).." = " .. tostring(round(newCondition,2)) .. " %)"
							end
						else
d("<<break loop -> Dead or crown repair kit used")
							totalDelay = 0
							break --leave the loop
						end
d("<< ???????????????????????????????????????")

					else

						--All other further slots to check
						--Delay each slot check by the milliseconds repair delay chosen in the settings menu
						zo_callLater(function()
d(">> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
d(">>Repair check further slot: " ..tostring(slot) .. " - " .. GetItemLink(BAG_WORN, slot))
							--Prevent the repair try if a crown store repair kit was used already
							if not wasCrownRepairKitUsed and not abortedDueToDeath then
								total, wasCrownRepairKitUsed, kitWasUsed, abortedDueToDeath, newCondition = REPAIR.RepairItem(BAG_WORN, slot, kits, minConditionPercent)
								--A repair kit was used?
								if not abortedDueToDeath and kitWasUsed then
									--Update the crown repair kit used flag
									if wasCrownRepairKitUsed then
d("<<return delayed call -> Crown repair kit used")
										totalDelay = 0
										return --end zo_callLater function
									end
								elseif abortedDueToDeath then
d("<<return delayed call -> Dead")
									totalDelay = 0
									return --end zo_callLater function
								end
							else
d("<<return delayed call -> Dead or crown repair kit used")
								totalDelay = 0
								return --end zo_callLater function
							end

							--Chat output needed? Append the output string, but only if no crown repair kit was used.
							-->Chat output text for crown repair kit usage will be done further down below
							if not abortedDueToDeath and chatOutput and not wasCrownRepairKitUsed and total > 0 and kitWasUsed then
								chatOutputStr = (chatOutputStr or GetString(ARC_CHATOUTPUT_REPAIRED))..((chatOutputStr and ", ") or "")..ARC_GetEquipSlotText(slot).." (+"..tostring(round(total,2)).." = " .. tostring(round(newCondition,2)) .. " %)"
							end
d("<< !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
						end, checkNextSlotDelay)

					end

					--Delay by n miliseconds between each repair attempt
					checkNextSlotDelay = checkNextSlotDelay + delayBetweenRepair

					--Update the total delay for the further checks and the chat output
					totalDelay = checkNextSlotDelay

				end

				--Slot to check was checked, abort other slot checks
				if slotIndex ~= nil then
		d("<abort loop -> SlotIndex was checked, all other are irrelevant")
					totalDelay = 0
					--Reset the "repair run" prevention variable so the next slotIndex check via durabilityChange can happen
					resetRepair()
					break
				end
			end
		else
d("<abort loop -> Crown repair kit used or dead")
			totalDelay = 0
			break -- crown repait kit has repaired all already or the player is dead meawhile, abort the loop
		end
	end

d(">total delay: " ..tostring(totalDelay))

	--Prepare the chat output by checking all worn equipment's condition now, after the total repair delay was waited
	if chatOutput == true then
		totalDelay = totalDelay + 25 --add a small delay before the chat output
		--Do the other chat output now
		zo_callLater(function()
d(">>0000000000 Delayed chatOutput 0000000000000")
			--Was a crown store repair kit used?
			-->Show the chat output for it as it was not done already above!
			if wasCrownRepairKitUsed then
d(">>>crown repair chat output")
				chatOutputStr = GetString(ARC_CHATOUTPUT_REPAIRED) .. " " .. GetString(SI_GAMEPAD_REPAIR_ALL_SUCCESS) .. " (+100 = 100 %)"
			end

			--Show nothing repaired chat outpout too?
			local chatOutputSuppressNothingMessages = settings.chatOutputSuppressNothingMessages
			if chatOutputStr == nil and not chatOutputSuppressNothingMessages then
d(">>>nothing repaired chat output")
				local condition
				for _, slot in ipairs(_repairSlots) do
					if HasItemInSlot(BAG_WORN, slot) then
						if slotIndex == nil or (slotIndex ~= nil and slotIndex == slot) then
							condition     = GetItemCondition(BAG_WORN,slot)
							chatOutputStr = (chatOutputStr or GetString(ARC_CHATOUTPUT_REPAIRED_NOTHING))..((chatOutputStr and ", ") or "")..ARC_GetEquipSlotText(slot).." (+0 = "..tostring(round(condition,2)).." %)"
							--Slot to check was found, abort other slot checks
							if slotIndex ~= nil then break end
						end
					end
				end
			end

			--Do the chat output now
			if chatOutputStr ~= nil then
				println(chatOutputStr)
			elseif chatOutputStr == nil and not chatOutputSuppressNothingMessages then
				println(GetString(ARC_CHATOUPUT_NO_REPAIRABLE_ARMOR))
			end
d("<<0000000000 Delayed chatOutput 0000000000000")
		end, totalDelay)
	end

	--Do the "repair kits soon empty checks" delayed, after chat output was done (if enabled)
	if not inCombat and settings.alertRepairKitsSoonEmpty then
		totalDelay = totalDelay + 10 --add 10 milliseconds
		zo_callLater(function()
d(">>delayed call 3 - repair kits left output")
			if not IsUnitInCombat(PLAYER) then
				ARC_checkThresholdOrEmpty("repairKits", false, kitsCount)
			end
		end, totalDelay)
	end

	--Reset the "repair is currently active" prevention variable
	totalDelay = totalDelay + 10 --add 10 milliseconds
	zo_callLater(function()
d(">>delayed call 4 - reset the repair prevention variable")
		resetRepair()
	end, totalDelay)
end

local function ARC_CombatStateChanged(eventCode, inCombat)
d("=========================================================")
d("[ARC]CombatStateChanged inCombat: " ..tostring(inCombat))
	--No repair or recharge if dead - Get current state by forcing the update
	isPlayerCurrentlyDead = ARC_IsPlayerDead(true)
	if isPlayerCurrentlyDead == true then return end

	local settings = Recharge.settings
	local chatOutput = settings.chatOutput
	--TODO enable again after debugging
	--[[
	if settings.chargeEnabled == true then
		if duringCombatCheck(settings.chargeDuringCombat, inCombat) then
			ARC_ChargeEquipped(chatOutput, inCombat, nil)
		end
	end
	]]

	if settings.repairEnabled == true then
		if duringCombatCheck(settings.repairDuringCombat, inCombat) then
			ARC_RepairEquipped(chatOutput, inCombat, nil)
		end
	end
end

local function ARC_DeathStateChanged(isDead)
d(">>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
d("[ARC]DeathStateChanged-isDead: " ..tostring(isDead))
	isPlayerCurrentlyDead = isDead
	if not isDead then
		--Reset the "no charge/durability event" slotIndices
		Recharge.noChargeChangeEvents = {}
		Recharge.noDurabilityChangeEvents = {}
	end
d("<<< ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
end

--EVENT_INVENTORY_SINGLE_SLOT_UPDATE: Item charge changed
-- (number eventCode, Bag bagId, number slotId, boolean isNewItem, ItemUISoundCategory itemSoundCategory, number inventoryUpdateReason, number stackCountChange)
local function ARC_Charge_Changed(eventCode, bagId, slotIndex)
--d("[ARC_Charge_Changed]" .. GetItemLink(bagId, slotIndex))
	--Prevent charge change events for slotIndices which recently got charged and where the soul stone usage
	--triggered the charge change event
	if Recharge.noChargeChangeEvents[slotIndex] then
		Recharge.noChargeChangeEvents[slotIndex] = nil
		return
	end

	local settings = Recharge.settings
	--Fix IsUnitDead("player") where the charge state changes but the player is not dead -> Charge starts -> Player is dead meanwhile
	--in system -> server kicks us because of message spamming as we try to charge something while we are dead
	--zo_callLater(function()
	--Is the setting enabled to check charges and recharge items during combat, and is the item currently worn?
	if not wornNotDeadAndNotInCombatChecks(bagId, settings.chargeDuringCombat) then return end

	--Check if the item needs to be recharged now
	ARC_ChargeEquipped(settings.chatOutput, true, slotIndex)
	--end, 1000)
end

--EVENT_INVENTORY_SINGLE_SLOT_UPDATE: Item durability changed
-- (number eventCode, Bag bagId, number slotId, boolean isNewItem, ItemUISoundCategory itemSoundCategory, number inventoryUpdateReason, number stackCountChange)
local function ARC_Durability_Changed(eventCode, bagId, slotIndex)
	--Fix IsUnitDead("player") where the durabilty changes but the player is not dead -> Repair starts -> Player is dead meanwhile
	--in system -> server kicks us because of message spamming as we try to repair something while we are dead
	zo_callLater(function()
d(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
d("[ARC_Durability_Changed]" .. GetItemLink(bagId, slotIndex))
		--Prevent durability change events for slotIndices which recently got repaired and where the repairKit usage
		--triggered the durability change event
		if Recharge.noDurabilityChangeEvents[slotIndex] then
d("<ABORTED - Durablity was changed by repairKit of this addon")
			Recharge.noDurabilityChangeEvents[slotIndex] = nil
			return
		end

		local settings = Recharge.settings
		--Is the setting enabled to check durability and repair items during combat, and is the item currently worn?
		if not wornNotDeadAndNotInCombatChecks(bagId, settings.repairDuringCombat) then return end

		--Check if the item needs to be repaired now
		ARC_RepairEquipped(settings.chatOutput, true, slotIndex)
d("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<")
	end, 100) --call slightly delayed
end

local function TryParseOnOff(str)
	local on = (str == "+" or str == "on" or str == "an" or str == "на") or false
	local off = (not on and (str == "-" or str == "off" or str == "aus" or str == "от")) or false
	if on == false and off == false then return nil end
	if on then return true end
	if off then return false end
	return nil
end

local function TryParsePercent(str)
	local percent = tonumber(str)
	if percent ~= nil and percent >= 0 and percent <= 100 then return (percent / 100) end
	return nil
end
Recharge.TryParsePercent = TryParsePercent



local function reAnchorControl(control, anchorMode, anchorToControl, anchorMode2, pX, pY)
    if control == nil then return end
    control:ClearAnchors()
    control:SetAnchor(anchorMode, anchorToControl, anchorMode2, pX, pY)
end

local function ARC_buildAndAnchorTexture(parentControl, textureName, texturePath, pWidth, pHeight, pR, pG, pB, pA, pX, pY, anchorToControl, anchorMode, anchorMode2, withLabel, labelAnchorControl, labelAnchorMode, labelAnchorMode2, label_pWidth, label_pHeight, label_pR, label_pG, label_pB, label_pA, label_pX, label_pY)
    if parentControl == nil or textureName == nil or texturePath == nil or anchorToControl == nil or anchorMode == nil then return end
    if anchorMode2 == nil then anchorMode2 = anchorMode end
    withLabel = withLabel or false
    pWidth = pWidth or 32
    pHeight = pHeight or 32
    pR = pR or 1
    pG = pG or 1
    pB = pB or 1
    pA = pA or 1
    pX = pX or 0
    pY = pY or 0

    --Create the texture control now
    local anchorName = anchorToControl:GetName()
    if anchorName == nil then return end
    local control = WINDOW_MANAGER:GetControlByName(anchorName .. "_" .. textureName, "")
    if control == nil then
        control = WINDOW_MANAGER:CreateControl(anchorName .. "_" .. textureName, parentControl, CT_TEXTURE)
    end
    if control == nil then return end
    control:SetDimensions(pWidth, pHeight)
    control:SetTexture(texturePath)
    control:SetColor(pR, pG, pB, pA)
    control:SetDrawTier(DT_HIGH)
    control:SetDrawLayer(DT_HIGH)
    reAnchorControl(control, anchorMode, anchorToControl, anchorMode2, pX, pY)

    labelAnchorControl = labelAnchorControl or control
    labelAnchorMode2 = labelAnchorMode2 or labelAnchorMode
    label_pWidth = label_pWidth or 25
    label_pHeight = label_pHeight or 15
    label_pX = label_pX or 0
    label_pY = label_pY or 0
    label_pR = label_pR or 1
    label_pG = label_pG or 1
    label_pB = label_pB or 1
    label_pA = label_pA or 1
    local labelControl
    --Create label control for the texture too?
    if withLabel and labelAnchorControl ~= nil and labelAnchorMode ~= nil and labelAnchorMode2 ~= nil then
        labelControl = WINDOW_MANAGER:CreateControl(anchorName .. "_" .. textureName .. "_LABEL", control, CT_LABEL)
        labelControl:SetFont("ZoFontWinH3")
        labelControl:SetScale(1)
        labelControl:SetDrawLayer(DT_HIGH)
        labelControl:SetDrawTier(DT_HIGH)
        labelControl:SetDimensions(label_pWidth, label_pHeight)
        labelControl:SetColor(label_pR, label_pG, label_pB, label_pA)
        labelControl:ClearAnchors()
        labelControl:SetAnchor(labelAnchorMode, labelAnchorControl, labelAnchorMode2, label_pX, label_pY)
    end
    return control, labelControl
end

local function ARC_InventorySingleSlotUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
	--d("[ARC_InventorySingleSlotUpdate] bagId: " .. tostring(bagId) ..", slotId: " .. tostring(slotId) .. ", isNewItem: " .. tostring(isNewItem) .. ", inventoryUpdateReason: " .. tostring(inventoryUpdateReason) ..", storeWindowHidden: " .. tostring(ZO_StoreWindow:IsHidden()) .. ", showRepairKitsAtVendor: " .. tostring(Recharge.settings.showRepairKitsLeftAtVendor))

--[[
    INVENTORY_UPDATE_REASON_DEFAULT				= 0
    INVENTORY_UPDATE_REASON_DURABILITY_CHANGE	= 1
    INVENTORY_UPDATE_REASON_DYE_CHANGE			= 2
    INVENTORY_UPDATE_REASON_ITEM_CHARGE			= 3
    INVENTORY_UPDATE_REASON_PLAYER_LOCKED		= 4
]]

	--Settings to show repairkits in vendor panel active? Is the vendor shown? Bag and slot are given? Item was bought new?
	if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT or not Recharge.settings.showRepairKitsLeftAtVendor or bagId == nil or slotId == nil then return false end
    --Was a new repair kit bought or one sold (isNewItem == false then)? Then update the repair kits shown
	if (not ZO_StoreWindow:IsHidden() and IsItemRepairKit(bagId, slotId)) or (ZO_StoreWindow:IsHidden() and not ZO_PlayerInventory:IsHidden() and isNewItem == false) then
		--Get the label control of the texture
		if Recharge.storeWindowRepairKitsLeftTextureLabel ~= nil then
			local kitsCount = ARC_GetRepairKitsCount()
			Recharge.storeWindowRepairKitsLeftTextureLabel:SetText(kitsCount)
		end
	end
end

local function ARC_Open_Store()
    if Recharge.settings.showRepairKitsLeftAtVendor then
        local vendorRepairKitsTextureName = eventName .. "_VENDOR_REPAIRKITS"
        if not Recharge.storeWindowRepairKitsLeftTexture then
            --Recharge.storeWindowRepairKitsLeftTexture, Recharge.storeWindowRepairKitsLeftTextureLabel = ARC_buildAndAnchorTexture(ZO_StoreWindowMenu, vendorRepairKitsTextureName, "esoui/art/icons/quest_crate_001.dds", 48, 48, 1, 1, 1, 1, -345, -38, ZO_StoreWindowMenuBar, TOPLEFT, BOTTOMLEFT, true, nil, RIGHT, RIGHT, 50, 25, 1, 1, 1, 1, 50, 0)
			Recharge.storeWindowRepairKitsLeftTexture, Recharge.storeWindowRepairKitsLeftTextureLabel = ARC_buildAndAnchorTexture(ZO_StoreWindowMenu, vendorRepairKitsTextureName, "esoui/art/icons/quest_crate_001.dds", 32, 32, 1, 1, 1, 1, -355, 28, ZO_StoreWindowMenuBar, TOPLEFT, BOTTOMLEFT, true, nil, RIGHT, RIGHT, 50, 25, 1, 1, 1, 1, 50, 0)
        end
        if Recharge.storeWindowRepairKitsLeftTexture then
            Recharge.storeWindowRepairKitsLeftTexture:SetHidden(false)
			--Reanchor it if we are at a normal vendor, a siege vendor or a store opened form our helpers
			local isStoreEmpty = IsStoreEmpty()
            local canStoreRepair = CanStoreRepair()
            local isSiegeVendor = false
			if canStoreRepair then
				if isSiegeVendor then
					--Store is a siege vendor
                    reAnchorControl(Recharge.storeWindowRepairKitsLeftTexture, TOPLEFT, ZO_StoreWindowMenuBar, BOTTOMLEFT, -455, 28)
				else
					--Store is a normal vendor
                    reAnchorControl(Recharge.storeWindowRepairKitsLeftTexture, TOPLEFT, ZO_StoreWindowMenuBar, BOTTOMLEFT, -355, 28)
				end
            else
                if isStoreEmpty then
                    --Store is our local helper
                    reAnchorControl(Recharge.storeWindowRepairKitsLeftTexture, TOPLEFT, ZO_StoreWindowMenuBar, BOTTOMLEFT, -455, 28)
                else
                    --Store is a normal vendor
                    reAnchorControl(Recharge.storeWindowRepairKitsLeftTexture, TOPLEFT, ZO_StoreWindowMenuBar, BOTTOMLEFT, -355, 28)
                end
			end
            --Get the label control of the texture
            if Recharge.storeWindowRepairKitsLeftTextureLabel ~= nil then
                local kitsCount = ARC_GetRepairKitsCount()
                Recharge.storeWindowRepairKitsLeftTextureLabel:SetText(kitsCount)
                Recharge.storeWindowRepairKitsLeftTextureLabel:SetHidden(false)

				--Register the event inventory single slot update for new bought repair kits
				EVENT_MANAGER:RegisterForEvent(eventName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ARC_InventorySingleSlotUpdate)
            end
        end
    end
end

local function ARC_Close_Store()
    --UnRegister the event inventory single slot update for new bought repair kits
    EVENT_MANAGER:UnregisterForEvent(eventName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if not Recharge.settings.showRepairKitsLeftAtVendor then
		if Recharge.storeWindowRepairKitsLeftTexture and not Recharge.storeWindowRepairKitsLeftTexture:IsHidden() then
        	Recharge.storeWindowRepairKitsLeftTexture:SetHidden(true)
		end
		if Recharge.storeWindowRepairKitsLeftTextureLabel and not Recharge.storeWindowRepairKitsLeftTextureLabel:IsHidden() then
        	Recharge.storeWindowRepairKitsLeftTextureLabel:SetHidden(true)
		end
    end
end

local function LoadSettings()
	if Recharge.settings then return end
	Recharge.settings = {}
	local worldName = GetWorldName()

	--Recharge.settings = ZO_SavedVars:NewCharacterIdSettings(Recharge.savedVarsName, Recharge.savedVarsVersion, "Settings", Recharge.defaultSettings, nil)
	Recharge.settings = ZO_SavedVars:NewAccountWide(Recharge.savedVarsName, 1, "Settings", Recharge.defaultSettings, worldName)
	if not Recharge.settings.AccountWide then ZO_SavedVars:NewCharacterIdSettings(Recharge.savedVarsName, Recharge.savedVarsVersion, "Settings", Recharge.defaultSettings, worldName) end
end


local function ARC_Initialize()
	SLASH_COMMANDS["/arc"] = function(arg)
		local settings = Recharge.settings
		arg = trim(arg)
		if arg == nil or arg == "" then
			if ARC_IsPlayerDead() == true then return end
			ARC_ChargeEquipped(true, nil, nil)
		else
			local percent = TryParsePercent(arg)
			if percent ~= nil and percent >= 0 and percent < 1 then
				settings.minChargePercent = percent
				println(GetString(ARC_CHATOUPUT_MIN_CHARGE),tostring(percent * 100),"%")
			elseif percent ~= nil then
				println(zo_strformat(GetString(ARC_CHATOUPUT_INVALID_PERCENTAGE), (percent * 100)))
			else
				local enabled = TryParseOnOff(arg)
				if enabled ~= nil then
					settings.chargeEnabled = enabled
					println(GetString(ARC_CHATOUPUT_CHARGE), ((enabled and GetString(ARC_CHATOUPUT_SETTINGS_ENABLED)) or GetString(ARC_CHATOUPUT_SETTINGS_DISABLED)))
				end
			end
		end

	end

	SLASH_COMMANDS["/arp"] = function(arg)
		local settings = Recharge.settings
		arg = trim(arg)
		if arg == nil or arg == "" then
			if ARC_IsPlayerDead() == true then return end
            ARC_RepairEquipped(true, nil, nil)
		else
			local percent = TryParsePercent(arg)

			if percent ~= nil and percent >= 0 and percent < 1 then
				settings.minConditionPercent = percent
				println(GetString(ARC_CHATOUPUT_MIN_CONDITION),tostring(percent * 100),"%")
			elseif percent ~= nil then
				println(zo_strformat(GetString(ARC_CHATOUPUT_INVALID_PERCENTAGE), (percent * 100)))
			else
				local enabled = TryParseOnOff(arg)
				if enabled ~= nil then
					settings.repairEnabled = enabled
					println(GetString(ARC_CHATOUPUT_REPAIR),((enabled and GetString(ARC_CHATOUPUT_SETTINGS_ENABLED)) or GetString(ARC_CHATOUPUT_SETTINGS_DISABLED)))
				end
			end

		end
	end

end

local function OnActiveWeaponPairChanged(eventId, activeWeaponPair, locked)
--d("[AutoRecharge]ActiveWeaponPairChanged-activeWeaponPair: " ..tostring(activeWeaponPair) .. ", locked: " ..tostring(locked))
	if locked then
		local settings = Recharge.settings
		if settings.chargeOnWeaponChange == true and ARC_IsPlayerDead() == false then
			local inCombat = IsUnitInCombat(PLAYER)
			if not inCombat and settings.chargeOnWeaponChangeOnlyInCombat == true then return end
			ARC_ChargeEquipped(settings.chatOutput, inCombat, nil)
		end
	end
end

local function ARC_Player_Activated(...)
	EVENT_MANAGER:UnregisterForEvent(eventName, EVENT_PLAYER_ACTIVATED)
	local settings = Recharge.settings
	isPlayerCurrentlyDead = IsUnitDead(PLAYER)
	Recharge.noChargeChangeEvents = {}
	Recharge.noDurabilityChangeEvents = {}


	--On a weapon pair change: Recharge checks?
	if settings.chargeOnWeaponChange == true then
		EVENT_MANAGER:RegisterForEvent(eventName, EVENT_ACTIVE_WEAPON_PAIR_CHANGED, OnActiveWeaponPairChanged)
	end

    if settings.alertSoulGemsEmptyOnLogin then
		local gemsCount = ARC_GetSoulGemsCount()
		ARC_checkThresholdOrEmpty("soulGems", gemsCount == 0, gemsCount)
    end
    if settings.alertRepairKitsEmptyOnLogin then
		local kitsCount = ARC_GetRepairKitsCount()
		ARC_checkThresholdOrEmpty("repairKits", kitsCount == 0, kitsCount)
    end
end

local function ARC_Loaded(eventCode, addOnName)
	if(addOnName ~= "Recharge") then
		return
	end
	--Unregister this event again so it isn't fired again after this addon has beend recognized
	EVENT_MANAGER:UnregisterForEvent(eventName, EVENT_ADD_ON_LOADED)
	LoadSettings()
	Recharge.BuildSettingsMenu()

	EVENT_MANAGER:RegisterForEvent(eventName, EVENT_PLAYER_ACTIVATED, ARC_Player_Activated)
	--Register for Store opened & closed
	EVENT_MANAGER:RegisterForEvent(eventName, EVENT_OPEN_STORE,  ARC_Open_Store)
	EVENT_MANAGER:RegisterForEvent(eventName, EVENT_CLOSE_STORE, ARC_Close_Store)

	--Items changed: Weapon charge (only worn items)
	local eventNameCharge = eventName .. eventSuffixCharge
	--TODO: re-enable after testing if this get#s you kicked too because of message spam!
	--EVENT_MANAGER:RegisterForEvent(eventNameCharge, 	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ARC_Charge_Changed)
	--EVENT_MANAGER:AddFilterForEvent(eventNameCharge, 	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_ITEM_CHARGE)
	--EVENT_MANAGER:AddFilterForEvent(eventNameCharge, 	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)

	--Items changed: Durability of repairable items (only worn items)
	local eventNameRepair = eventName .. eventSuffixRepair
	EVENT_MANAGER:RegisterForEvent(eventNameRepair, 	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, ARC_Durability_Changed)
	EVENT_MANAGER:AddFilterForEvent(eventNameRepair, 	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DURABILITY_CHANGE)
	EVENT_MANAGER:AddFilterForEvent(eventNameRepair, 	EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN)

	EVENT_MANAGER:RegisterForEvent(eventName, EVENT_PLAYER_COMBAT_STATE, ARC_CombatStateChanged)
	EVENT_MANAGER:RegisterForEvent(eventName, EVENT_PLAYER_DEAD, 	function() ARC_DeathStateChanged(true) end)
	EVENT_MANAGER:RegisterForEvent(eventName, EVENT_PLAYER_ALIVE, 	function() ARC_DeathStateChanged(false) end)

	ARC_Initialize()
end

--function to trigger the repair via keybind
function Recharge.Keybind_Repair()
	if ARC_IsPlayerDead() == false then
		LoadSettings()
		ARC_RepairEquipped(Recharge.settings.chatOutput, false, nil)
	end
end

--function to trigger the recharge via keybind
function Recharge.Keybind_Recharge()
	if ARC_IsPlayerDead() == false then
		LoadSettings()
		ARC_ChargeEquipped(Recharge.settings.chatOutput, false, nil)
	end
end

--Function to trigger the auto repair/recharge via keybind
function Recharge.Triggle_Action()
	if ARC_IsPlayerDead() == false then
		Recharge.Keybind_Recharge()
		Recharge.Keybind_Repair()
	end
end

EVENT_MANAGER:RegisterForEvent(eventName, EVENT_ADD_ON_LOADED, ARC_Loaded)

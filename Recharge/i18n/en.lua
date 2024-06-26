local strings = {
--Addon LAM menu
	ARC_LAM_ADDON_DESC								= "Recharges and repairs your equipped weapons and amour automatically upon entering and leaving combat.",
	ARC_LAM_OPTION_ACCOUNTWIDE						= "Use accountwide settings",
	ARC_LAM_OPTION_ACCOUNTWIDE_TT					= "Save the addon settings for all your characters of your account, or single for each character.",
	ARC_LAM_HEADER_AUTO_CHARGE						= GetString(SI_CHARGE_WEAPON_TITLE),
	ARC_LAM_OPTION_AUTO_RECHARGE						= GetString(SI_CHARGE_WEAPON_TITLE) .. " automatically",
	ARC_LAM_OPTION_AUTO_RECHARGE_TT					= "Automatically recharge your weapons upon entering/leaving combat. " .. GetString(SI_CHARGE_WEAPON_CONSUME),
	ARC_LAM_OPTION_AUTO_RECHARGE_DELAY				= "Recharge delay",
	ARC_LAM_OPTION_AUTO_RECHARGE_DELAY_TT			= "With this time in milliseconds (ms) between each recharge try -> avoid getting kicked for spamming the server!\nDepending on your enabled amount of addons, gaming time, server stress due to active events and many players playing you may need to increase this number!",
	ARC_LAM_OPTION_AUTO_REPAIR_DELAY					= "Repair delay",
	ARC_LAM_OPTION_AUTO_REPAIR_DELAY_TT				= "With this time in milliseconds (ms) between each repair try -> avoid getting kicked for spamming the server!\nDepending on your enabled amount of addons, gaming time, server stress due to active events and many players playing you may need to increase this number!",
	ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH	 			= "Minimum charge percentage",
	ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH_TT			= "Set a value between 0% and 99%. Weapons will be recharged when the current charge percentage is equal to or lower than this value.",
	ARC_LAM_HEADER_AUTO_REPAIR						= GetString(SI_ITEM_ACTION_REPAIR) .. " " .. GetString(SI_ITEM_FORMAT_STR_ARMOR),
	ARC_LAM_OPTION_AUTO_REPAIR						= "Automatic armour repair",
	ARC_LAM_OPTION_AUTO_REPAIR_TT		   			= "Automatically repair your armour upon entering/leaving combat. " .. GetString(SI_REPAIR_KIT_CONSUME),
	ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH   				= "Minimum condition percentage",
	ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH_TT				= "Set a value between 0% and 99%. Armour will be repaired when the current condition percentage is equal to or lower than this value.",
	ARC_LAM_HEADER_CHATOUTPUT						= GetString(SI_CHAT_TAB_GENERAL) .. " " .. GetString(SI_AUDIO_OPTIONS_OUTPUT),
    ARC_LAM_OPTION_SHOW_CHAT_MSG						= "Shows chat messages",
	ARC_LAM_OPTION_SHOW_CHAT_MSG_TT					= "Shows chat messages if repair/weapon recharge fails, etc.",
	ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING			= "Suppress 'Nothing ...' messages",
	ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING_TT		= "Do not show the 'Charged nothing' or 'Repaired nothing' messages",
	ARC_LAM_HEADER_ALERT 							= "Onscreen messages",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT				= "Show 'Repair kit empty' alert",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TT			= "Shows onscreen alert message if your repair kits are empty",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT		= "Show 'Repair kit soon empty' alert",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT_TT		= "Shows onscreen alert message if your repair kits amount drops below a threshold.\n\nSet your threshold at the slider to the right!",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH			= "Repair kits threshold",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH_TT		= "Set a value between 1 and 100 repair kits. If you leave combat and your repair kits drop below this value you'll get an onscreen alert message.",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN		= "Shows 'Repair kits' alert at login/reloadui",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN_TT	= "As you login or do a reloadui:\nShow onscreen alert message if your Repair kits amount drops below the chosen threshold or is already 0.",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_VENDOR		= "Shows 'Repair kits' alert at vendor",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_VENDOR_TT	= "As you open a vendor:\nShow onscreen alert message if your Repair kits amount drops below the chosen threshold or is already 0.",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM				= "Show '" .. GetString(SI_ITEMTYPE19) .. " empty' alert",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TT			= "Shows onscreen alert message if your Soul gems are empty",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM			= "Show '" .. GetString(SI_ITEMTYPE19) .. " empty soon' alert",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM_TT		= "Shows onscreen alert message if your Soul gems amount drops below a threshold.\n\nSet your threshold at the slider to the right!",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH			= GetString(SI_ITEMTYPE19) .. " threshold",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH_TT			= "Set a value between 1 and 100 Soul gems. If you leave combat and your Soul gems drop below this value you'll get an onscreen alert message.",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN	  		= "Shows '" .. GetString(SI_ITEMTYPE19) .. "' alert at login/reloadui",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN_TT		= "As you login or do a reloadui:\nShow onscreen alert message if your " .. GetString(SI_ITEMTYPE19) .. " amount drops below the chosen threshold or is already 0.",
	ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR	= "Show repair kits left at vendor",
	ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR_TT= "Shows the repair kits that you got left, if you talk to a vendor, as a small icon with the number of repair kits left next to it.",
	ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL	= "Use repair kit for item level",
	ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL_TT = "If you own several repair kits the appropriate one will be used for the item's level (e.g. 'grand kit' for CP 160 items), repairing your item to at least 90% condition",
	ARC_LAM_OPTION_DO_NOT_USE_CROWN_STORE_REPAIR_KITS= "Don't use crown shop repair kits",
	ARC_LAM_OPTION_DO_NOT_USE_CROWN_STORE_REPAIR_KITS_TT = "With this setting enabled no crown shop repair kits will be used for automatic repairs.",
	ARC_LAM_OPTION_USE_CROWN_STORE_REPAIR_KITS_FIRST = "Crown repair kits first",
	ARC_LAM_OPTION_USE_CROWN_STORE_REPAIR_KITS_FIRST_TT = "Use the Crown Store repair kits first, and if noone is left use the normal repair kits",
	ARC_LAM_OPTION_USE_CROWN_STORE_SOULGEMS_FIRST = "Crown soulgems first",
	ARC_LAM_OPTION_USE_CROWN_STORE_SOULGEMS_FIRST_TT = "Use the Crown Store soulgemns first, and if noone is left use the normal soulgems",

	ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT			= "Recharge in combat",
	ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT_TT		= "Automatically recharge your weapons also during the combat",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE		= "Recharge on weapon change",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_TT	= "Check and recharge the weapons on a weapon pair change.",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_ONLY_IN_COMBAT = "Weapon change check: Only in combat",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_ONLY_IN_COMBAT_TT = "Do the recharge on weapon change check only if you are in combat",
	ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT				= "Repair in combat",
	ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT_TT		   	= "Automatically repair your armour also during the combat",

	ARC_LAM_OPTION_ALERT_RELOADUI_LOGIN_ZONING 		= "Only at login/reloadUI/zoning",
	ARC_LAM_OPTION_ALERT_RELOADUI_LOGIN_ZONING_TT	= "Show the alert only if you login, do a /reloadui or change zones (where a loading screen appears)",
	ARC_LAM_OPTION_ALERT_VENDOR						= "Show alert at vendor",
	ARC_LAM_OPTION_ALERT_VENDOR_TT					= "As you open a vendor:\nShow onscreen alert message.",

--Chat output messages
	ARC_CHATOUTPUT_CHARGED							= GetString(SI_ITEMTRAITTYPE2) .. ": ",
	ARC_CHATOUTPUT_CHARGED_NOTHING	   				= GetString(SI_ITEMTRAITTYPE2) .. " nothing: ",
	ARC_CHATOUPUT_NO_CHARGEABLE_WEAPONS				= GetString(SI_SOULGEMITEMCHARGINGREASON1),
	ARC_CHATOUTPUT_REPAIRED							= "Repaired: ",
	ARC_CHATOUTPUT_REPAIRED_NOTHING					= "Repaired nothing: ",
	ARC_CHATOUPUT_NO_REPAIRABLE_ARMOR				= GetString(SI_NO_REPAIRS_TO_MAKE),

	ARC_CHATOUPUT_MIN_CHARGE 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_CHARGE_WEAPON_CONFIRM) .. ": ",
	ARC_CHATOUPUT_MIN_CONDITION 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_REPAIR_SORT_TYPE_CONDITION) .. ": ",
	ARC_CHATOUPUT_INVALID_PERCENTAGE					= "Invalid percentage: <<C:1>>, range: 0-99.",
	ARC_CHATOUPUT_CHARGE								= GetString(SI_CHARGE_WEAPON_CONFIRM) .. " ",
	ARC_CHATOUPUT_REPAIR								= GetString(SI_REPAIR_KIT_TITLE) .. " ",
    ARC_CHATOUPUT_SETTINGS_ENABLED					= GetString(SI_ADDON_MANAGER_ENABLED),
    ARC_CHATOUPUT_SETTINGS_DISABLED					= GetString(SI_CHECK_BUTTON_DISABLED),

	ARC_CHATOUPUT_REPAIRKITS_EMPTY_THRESHOLD			= "Repair kits empty threshold: ",
    ARC_CHATOUPUT_SOULGEMS_EMPTY_THRESHOLD			= GetString(SI_ITEMTYPE19) .." empty threshold: ",

--Alert messages
	ARC_ALERT_REPAIRKITS_EMPTY						= "Repair kits are empty!",
	ARC_ALERT_REPAIRKITS_SOON_EMPTY					= "Repair kits are empty soon! Only <<C:1>> left!",
	ARC_ALERT_SOULGEMS_EMPTY							= GetString(SI_ITEMTYPE19) .. " are empty!",
	ARC_ALERT_SOULGEMS_SOON_EMPTY					= GetString(SI_ITEMTYPE19) .. " are empty soon! Only <<C:1>> left!",

--Keybindings
    SI_KEYBINDINGS_CATEGORY_RECHARGE                    = "Auto Recharge",
    SI_BINDING_NAME_RUN_RECHARGE                        = "Triggle AutoRecharge and AutoRepair",
	SI_BINDING_NAME_RUN_REPAIR_SINGLE					= "Triggle AutoRepair",
	SI_BINDING_NAME_RUN_RECHARGE_SINGLE					= "Triggle AutoRecharge",
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end

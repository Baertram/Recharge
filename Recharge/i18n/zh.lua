--zh.lua

local strings = {
--Addon LAM menu
	ARC_LAM_ADDON_DESC								= "在进入和离开战斗时自动为装备的武器和护具充能和修复。",
	ARC_LAM_OPTION_ACCOUNTWIDE						= "同步玩家账户下所有角色的设置",
	ARC_LAM_OPTION_ACCOUNTWIDE_TT					= "为账户中的所有角色统一保存插件设置，或是为每个角色各自单独保存。",
	ARC_LAM_HEADER_AUTO_CHARGE						= GetString(SI_CHARGE_WEAPON_TITLE),
	ARC_LAM_OPTION_AUTO_RECHARGE						= GetString(SI_CHARGE_WEAPON_TITLE) .. "自动化",
	ARC_LAM_OPTION_AUTO_RECHARGE_TT					= "在进入/离开战斗时自动为武器充能。" .. GetString(SI_CHARGE_WEAPON_CONSUME),
	ARC_LAM_OPTION_AUTO_RECHARGE_DELAY				= "充能延迟",
	ARC_LAM_OPTION_AUTO_RECHARGE_DELAY_TT			= "每次充能之间的延迟时间，以毫秒（ms）为单位，以尽量避免被踢出服务器！\n根据您启用的插件数量、游戏时间、活动造成的服务器压力以及其他玩家的游戏情况，您可能需要增加这个数字！",
	ARC_LAM_OPTION_AUTO_REPAIR_DELAY					= "修理延迟",
	ARC_LAM_OPTION_AUTO_REPAIR_DELAY_TT				= "每次修理之间的延迟时间，以毫秒（ms）为单位，以尽量避免被踢出服务器！\n根据您启用的插件数量、游戏时间、活动造成的服务器压力以及其他玩家的游戏情况，您可能需要增加这个数字！",
	ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH	 			= "最低充能百分比",
	ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH_TT			= "设置一个介于 0% 和 99% 之间的值。如果当前装备充能百分比等于或低于该值时，将对武器进行充能。",
	ARC_LAM_HEADER_AUTO_REPAIR						= GetString(SI_ITEM_ACTION_REPAIR) .. " " .. GetString(SI_ITEM_FORMAT_STR_ARMOR),
	ARC_LAM_OPTION_AUTO_REPAIR						= "自动修复护甲",
	ARC_LAM_OPTION_AUTO_REPAIR_TT		   			= "在进入/离开战斗时自动修复护甲。" .. GetString(SI_REPAIR_KIT_CONSUME),
	ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH   				= "最低修理百分比",
	ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH_TT				= "设置一个介于 0% 和 99% 之间的值。如果当前护甲耐久值的百分比等于或低于该值时，将修复护甲。",
	ARC_LAM_HEADER_CHATOUTPUT						= GetString(SI_CHAT_TAB_GENERAL) .. " " .. GetString(SI_AUDIO_OPTIONS_OUTPUT),
    ARC_LAM_OPTION_SHOW_CHAT_MSG						= "显示聊天框信息",
	ARC_LAM_OPTION_SHOW_CHAT_MSG_TT					= "在修复/武器充能失败等情况下，显示聊天框信息。",
	ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING			= "忽略“...失败”信息",
	ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING_TT		= "不显示“充能失败”或“修理失败”的信息",
	ARC_LAM_HEADER_ALERT 							= "屏幕信息",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT				= "显示 '修理包用完了' 警告",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TT			= "如果修理包用完了，屏幕上会显示提示信息",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT		= "显示 '修理包快用完了' 警告",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT_TT		= "如果修理包数量低于阈值，屏幕上会显示提示信息。\n\n通过右侧的滑块设置阈值！",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH			= "修理包阈值",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH_TT		= "在 1 ~ 100 之间设置一个值。如果您离开战斗，并且您的修理包数量降到了这个值以下，您就会收到屏幕上的提示信息。",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN		= "在登录/重新加载UI时显示'修理包'警告",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN_TT	= "在登录/重新加载UI时：\n如果修理包数量低于所设置的阈值，或已经为0，屏幕上会显示提示信息。",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_VENDOR		= "在商人交易界面显示修理包警告",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_VENDOR_TT	= "当你打开商人交易界面时：\n如果修理包数量低于所设置的阈值，或已经为0，屏幕上会显示提示信息。",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM				= "显示 '" .. GetString(SI_ITEMTYPE19) .. "用完了' 警告",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TT			= "如果灵魂石用完了，屏幕上会显示提示信息",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM			= "显示 '" .. GetString(SI_ITEMTYPE19) .. "快用完了' 警告",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM_TT		= "如果灵魂石数量低于阈值，屏幕上会显示提示信息。\n\n通过右侧的滑块设置阈值！",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH			= GetString(SI_ITEMTYPE19) .. " 阈值",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH_TT			= "在1~100之间设置一个值。如果您离开战斗，并且您的灵魂石数量降到了这个值以下，您就会收到屏幕上的提示信息。",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN	  		= "在登录/重新加载UI时显示'" .. GetString(SI_ITEMTYPE19) .. "'警告",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN_TT		= "在登录/重新加载UI时：\n如果" .. GetString(SI_ITEMTYPE19) .. "数量低于所设置的阈值，或已经为0，屏幕上会显示提示信息。",
	ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR	= "在商人交易界面显示剩余修理包个数",
	ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR_TT= "如果您与商人交谈，则会以小图标的形式显示您所剩的修理包，图标旁边会显示所剩修理包的数量。",
	ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL	= "根据物品等级使用修理包",
	ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL_TT = "如果您拥有多种修理包，则将根据物品的等级使用相应的修理包（例如修理CP 160的物品），将物品修复到至少90%的状态",
	ARC_LAM_OPTION_DO_NOT_USE_CROWN_STORE_REPAIR_KITS= "不使用王冠修理包",
	ARC_LAM_OPTION_DO_NOT_USE_CROWN_STORE_REPAIR_KITS_TT = "启用此设置后，自动修理将不使用王冠修理包。",
	ARC_LAM_OPTION_USE_CROWN_STORE_REPAIR_KITS_FIRST = "王冠修理包优先",
	ARC_LAM_OPTION_USE_CROWN_STORE_REPAIR_KITS_FIRST_TT = "优先使用王冠修理包。如果没有了，再使用普通修理包",
	ARC_LAM_OPTION_USE_CROWN_STORE_SOULGEMS_FIRST = "王冠灵魂石优先",
	ARC_LAM_OPTION_USE_CROWN_STORE_SOULGEMS_FIRST_TT = "优先使用王冠灵魂石。如果没有了，再使用普通灵魂石",

	ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT			= "在战斗中充能",
	ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT_TT		= "在战斗中自动为武器充能。",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE		= "切换武器时充能",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_TT	= "在切换武器时检查武器并为其充能。",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_ONLY_IN_COMBAT = "武器更换检查： 仅在战斗中",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_ONLY_IN_COMBAT_TT = "只有在战斗中才进行武器更换充能检查",
	ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT				= "在战斗中修理",
	ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT_TT		   	= "在战斗中自动修理武器。",

	ARC_LAM_OPTION_ALERT_RELOADUI_LOGIN_ZONING 		= "仅在登录/重新加载UI/切换地图时使用",
	ARC_LAM_OPTION_ALERT_RELOADUI_LOGIN_ZONING_TT	= "仅在登录、执行/reloadui命令或更改区域（出现加载屏幕）时才显示警报",
	ARC_LAM_OPTION_ALERT_VENDOR						= "在商人交易界面显示警告",
	ARC_LAM_OPTION_ALERT_VENDOR_TT					= "当你打开商人交易界面时：\n显示屏幕提示信息。",

--Chat output messages
	ARC_CHATOUTPUT_CHARGED							= GetString(SI_ITEMTRAITTYPE2) .. "：",
	ARC_CHATOUTPUT_CHARGED_NOTHING	   				= GetString(SI_ITEMTRAITTYPE2) .. " 失败：",
	ARC_CHATOUPUT_NO_CHARGEABLE_WEAPONS				= GetString(SI_SOULGEMITEMCHARGINGREASON1),
	ARC_CHATOUTPUT_REPAIRED							= "已修理：",
	ARC_CHATOUTPUT_REPAIRED_NOTHING					= "修理失败：",
	ARC_CHATOUPUT_NO_REPAIRABLE_ARMOR				= GetString(SI_NO_REPAIRS_TO_MAKE),

	ARC_CHATOUPUT_MIN_CHARGE 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_CHARGE_WEAPON_CONFIRM) .. "：",
	ARC_CHATOUPUT_MIN_CONDITION 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_REPAIR_SORT_TYPE_CONDITION) .. "：",
	ARC_CHATOUPUT_INVALID_PERCENTAGE					= "无效百分比：<<C:1>>，范围：0-99。",
	ARC_CHATOUPUT_CHARGE								= GetString(SI_CHARGE_WEAPON_CONFIRM) .. " ",
	ARC_CHATOUPUT_REPAIR								= GetString(SI_REPAIR_KIT_TITLE) .. " ",
    ARC_CHATOUPUT_SETTINGS_ENABLED					= GetString(SI_ADDON_MANAGER_ENABLED),
    ARC_CHATOUPUT_SETTINGS_DISABLED					= GetString(SI_CHECK_BUTTON_DISABLED),

	ARC_CHATOUPUT_REPAIRKITS_EMPTY_THRESHOLD			= "修理包的阈值：",
    ARC_CHATOUPUT_SOULGEMS_EMPTY_THRESHOLD			= GetString(SI_ITEMTYPE19) .."的阈值：",

--Alert messages
	ARC_ALERT_REPAIRKITS_EMPTY						= "修理包用完了！",
	ARC_ALERT_REPAIRKITS_SOON_EMPTY					= "修理包快用完了！还剩下<<C:1>>个！",
	ARC_ALERT_SOULGEMS_EMPTY							= GetString(SI_ITEMTYPE19) .. "用完了！",
	ARC_ALERT_SOULGEMS_SOON_EMPTY					= GetString(SI_ITEMTYPE19) .. "快用完了！还剩下<<C:1>>个！",

--Keybindings
    SI_KEYBINDINGS_CATEGORY_RECHARGE                    = "Auto Recharge",
    SI_BINDING_NAME_RUN_RECHARGE                        = "使用 AutoRecharge 和 AutoRepair",
	SI_BINDING_NAME_RUN_REPAIR_SINGLE					= "使用 AutoRepair",
	SI_BINDING_NAME_RUN_RECHARGE_SINGLE					= "使用 AutoRecharge",
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end
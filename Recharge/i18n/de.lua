local strings = {
--Addon LAM menu
	SI_ARC_LAM_ADDON_DESC								= "Beim Eintreten oder Verlassen eines Kampfes, werden automatischen deine Waffen aufgeladen und deine Rüstung repariert.",
	SI_ARC_LAM_OPTION_ACCOUNTWIDE						= "Accountweite Einstellung",
	SI_ARC_LAM_OPTION_ACCOUNTWIDE_TT					= "Wenn du diese Einstellung aktivierst, werden die Einstellungen auf alle deiner Charakter übernommen.",
	SI_ARC_LAM_HEADER_AUTO_CHARGE						= GetString(SI_CHARGE_WEAPON_TITLE),
	SI_ARC_LAM_OPTION_AUTO_RECHARGE						= "Automatisch " .. GetString(SI_CHARGE_WEAPON_TITLE),
	SI_ARC_LAM_OPTION_AUTO_RECHARGE_TT					= "Beim Eintreten/Verlassen eines Kampfes, wird automatisch die Waffen aufgeladen, sofern diese Einstellung aktiviert ist. " .. GetString(SI_CHARGE_WEAPON_CONSUME),
	SI_ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH	 			= "Grenzwert [%] zum Aufladen",
	SI_ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH_TT			= "Setze einen Wert zwischen 0-99%. Deine Waffen werden automatisch aufgeladen, sobald dieser Wert erreicht oder unterschritten wird.",
	SI_ARC_LAM_HEADER_AUTO_REPAIR						= GetString(SI_ITEM_FORMAT_STR_ARMOR) .. " reparieren",
	SI_ARC_LAM_OPTION_AUTO_REPAIR						= "Automatisch Reparieren",
	SI_ARC_LAM_OPTION_AUTO_REPAIR_TT		   			= "Beim Eintreten/Verlassen eines Kampfes, wird automatisch die Rüstung repariert, sofern diese Einstellung aktiviert ist. " .. GetString(SI_REPAIR_KIT_CONSUME),
	SI_ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH   				= "Grenzwert [%] zum Reparieren",
	SI_ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH_TT				= "Setze einen Wert zwischen 0-99%. Deine Rüstung wird automatisch repariert, sobald dieser Wert erreicht oder unterschritten wird.",
	SI_ARC_LAM_HEADER_CHATOUTPUT						= GetString(SI_CHAT_TAB_GENERAL) .. " " .. GetString(SI_AUDIO_OPTIONS_OUTPUT),
    SI_ARC_LAM_OPTION_SHOW_CHAT_MSG						= "Chatmitteilungen",
	SI_ARC_LAM_OPTION_SHOW_CHAT_MSG_TT					= "Zeigt dir Chatmitteilungen an, wenn aufgeladen/repariert wurde, oder ein Fehler auftrat.",
	SI_ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING			= "Deaktiviere die \'Nichts ...\' Mitteilungen",
	SI_ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING_TT		= "Deaktiviert die \'Nichts geladen\' und die \'Nichts repariert\' Mitteilungen",
	SI_ARC_LAM_HEADER_ALERT 							= "Alarm Meldungen",
	
	SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT				= "Zeigt \'Reparatursets leer\' Meldungen",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TT			= "Bei leeren Reparatursets wird eine Alarm Meldung in der Mitte vom Bildschirm angezeigt",
	SI_ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT		= "Zeigt \'Reparatursets gehen bald aus\' Meldungen",
	SI_ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT_TT		= "Wenn deine Reparatursets knapp werden, wird eine Alarm Meldung in der Mitte vom Bildschirm angezeigt.\n\nSetzte den Grenzwert der Meldung auf der rechten Seite fest!",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH			= "Grenzwert Meldung",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH_TT		= "Wähle einen Wert zwischen 1 und 100 aus. Falls du den Wert erreichst oder unterschreitest, nachdem ein Kampf beendet ist, wird es dir eine Alarm Meldung anzeigen.",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN		= "Zeigt \'Reparatursets leer\' nach Anmelden/Reloadui",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN_TT	= "Wenn aktiviert wird es dir eine Alarm Meldung nach dem Anmelden/Reloadui zeigen, sofern der Grenzwert erreicht oder unterschritten wird.",
	
	SI_ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM				= "Zeigt \'" .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " leer\' Meldungen",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TT			= "Bei leeren " .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " wird eine Alarm Meldung in der Mitte vom Bildschirm angezeigt",
	SI_ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM			= "Zeigt \'" .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " gehen bald aus \' Meldungen",
	SI_ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM_TT		= "Wenn deine " .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " knapp werden, wird eine Alarm Meldung in der Mitte vom Bildschirm angezeigt.\n\nSetzte den Grenzwert der Meldung auf der rechten Seite fest!",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH			= "Grenzwert Meldung",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH_TT			= GetString(SI_ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH_TT),
	SI_ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN	  		= "Zeige \'" .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " leer \' nach Anmelden/Reloadui",
	SI_ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN_TT		= "Wenn aktiviert wird es dir eine Alarm Meldung nach dem Anmelden/Reloadui zeigen, sofern der Grenzwert erreicht oder unterschritten wird.",

	SI_ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR	= "Zeige restl. Reperatursets beim Händler",
	SI_ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR_TT= "Zeigt deine aktuell verbliebenen Reperatursets bei einem Hädnler als kleines Symbol mit der Anzahl daneben an.",
	SI_ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL	= "Reperaturset entspricht Level",
	SI_ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL_TT = "Sollten verschiedene Reperatursets im Inventar verfügbar sein, so wird das dem zu reparierenden Gegenstand entsprechende verwendet (z.B. 'Groß' für CP160 Rüstung)",

	--Chat output messages
	SI_ARC_CHATOUTPUT_CHARGED							= GetString(SI_ITEMTRAITTYPE2) .. ": ",
	SI_ARC_CHATOUTPUT_CHARGED_NOTHING	   				= zo_strformat("Nichts <<c:1>>:", GetString(SI_ITEMTRAITTYPE2)),
	SI_ARC_CHATOUPUT_NO_CHARGEABLE_WEAPONS				= GetString(SI_SOULGEMITEMCHARGINGREASON1),
	SI_ARC_CHATOUTPUT_REPAIRED							= "Repariert: ",
	SI_ARC_CHATOUTPUT_REPAIRED_NOTHING					= "Nichts repariert: ",
	SI_ARC_CHATOUPUT_NO_REPAIRABLE_ARMOR				= GetString(SI_NO_REPAIRS_TO_MAKE),

	SI_ARC_CHATOUPUT_MIN_CHARGE 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_CHARGE_WEAPON_CONFIRM) .. ": ",
	SI_ARC_CHATOUPUT_MIN_CONDITION 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_REPAIR_SORT_TYPE_CONDITION) .. ": ",
	SI_ARC_CHATOUPUT_INVALID_PERCENTAGE					= "Ungültiger Prozentsatz: <<C:1>>, Werte: 0-99.",
	SI_ARC_CHATOUPUT_CHARGE								= GetString(SI_CHARGE_WEAPON_CONFIRM) .. " ",
	SI_ARC_CHATOUPUT_REPAIR								= GetString(SI_REPAIR_KIT_TITLE) .. " ",
    SI_ARC_CHATOUPUT_SETTINGS_ENABLED					= GetString(SI_ADDON_MANAGER_ENABLED),
    SI_ARC_CHATOUPUT_SETTINGS_DISABLED					= GetString(SI_CHECK_BUTTON_DISABLED),

	SI_ARC_CHATOUPUT_REPAIRKITS_EMPTY_THRESHOLD			= "Grenze leere "  .. GetString(SI_HOOK_POINT_STORE_REPAIR_KIT_HEADER) .. " ",
    SI_ARC_CHATOUPUT_SOULGEMS_EMPTY_THRESHOLD			= "Grenze leere " .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. ": ",

	SI_ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT			= GetString(SI_CHARGE_WEAPON_TITLE) .. " im Kampf",
	SI_ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT_TT		= "Automatisch deine Waffen auch im Kampf aufladen",
	SI_ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT				= "Reparieren im Kampf",
	SI_ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT_TT		   	= "Automatisch deine Rüstung auch im Kampf reparieren",

--Alert messages
	SI_ARC_ALERT_REPAIRKITS_EMPTY						= "Die Reparatursets sind ausgegangen!",
	SI_ARC_ALERT_REPAIRKITS_SOON_EMPTY					= "Die Reparatursets gehen bald aus! Nur <<C:1>> übrig!",
	SI_ARC_ALERT_SOULGEMS_EMPTY							= "Die " .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " sind ausgegangen!",
	SI_ARC_ALERT_SOULGEMS_SOON_EMPTY					= "Die " .. GetString(SI_CUSTOMERSERVICESUBMITFEEDBACKSUBCATEGORIES406) .. " gehen bald aus! Nur <<C:1>> übrig!",

    --Keybindings
    SI_KEYBINDINGS_CATEGORY_RECHARGE                    = "Auto Recharge",
    SI_BINDING_NAME_RUN_RECHARGE                        = "Nutze AutoRecharge/AutoRepair",
	SI_BINDING_NAME_RUN_REPAIR_SINGLE					= "Nutze AutoRepair",
	SI_BINDING_NAME_RUN_RECHARGE_SINGLE					= "Nutze AutoRecharge",
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end

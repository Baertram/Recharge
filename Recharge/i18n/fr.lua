local strings = {
--Addon LAM menu
	ARC_LAM_ADDON_DESC								= "Recharge et répare automatiquement vos armes et votre armure équipés à l'entrée et à la sortie du combat.",
	ARC_LAM_OPTION_ACCOUNTWIDE						= "Utiliser les paramètres du compte",
	ARC_LAM_OPTION_ACCOUNTWIDE_TT					= "Enregistrez les paramètres de l'addon pour tous vos personnages de votre compte, ou unique pour chaque personnage.",
	ARC_LAM_HEADER_AUTO_CHARGE						= GetString(SI_CHARGE_WEAPON_TITLE),
	ARC_LAM_OPTION_AUTO_RECHARGE						= GetString(SI_CHARGE_WEAPON_TITLE) .. " automatiquement",
	ARC_LAM_OPTION_AUTO_RECHARGE_TT					= "Rechargez automatiquement vos armes en entrant/sortant du combat. " .. GetString(SI_CHARGE_WEAPON_CONSUME),
	ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH	 			= "Pourcentage de charge minimum",
	ARC_LAM_OPTION_AUTO_RECHARGE_MIN_TH_TT			= "Définissez une valeur entre 0% et 99%. Les armes seront rechargées lorsque le pourcentage de charge actuel est égal ou inférieur à cette valeur.",
	ARC_LAM_HEADER_AUTO_REPAIR						= GetString(SI_ITEM_ACTION_REPAIR) .. " " .. GetString(SI_ITEM_FORMAT_STR_ARMOR),
	ARC_LAM_OPTION_AUTO_REPAIR						= "Réparation d'armure automatique",
	ARC_LAM_OPTION_AUTO_REPAIR_TT		   			= "Réparez automatiquement votre armure en entrant/sortant du combat. " .. GetString(SI_REPAIR_KIT_CONSUME),
	ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH   				= "Pourcentage de condition minimum",
	ARC_LAM_OPTION_AUTO_REPAIR_MIN_TH_TT				= "Définissez une valeur entre 0% et 99%. L'armure sera réparée lorsque le pourcentage de condition actuelle est égal ou inférieur à cette valeur.",
	ARC_LAM_HEADER_CHATOUTPUT						= GetString(SI_CHAT_TAB_GENERAL) .. " " .. GetString(SI_AUDIO_OPTIONS_OUTPUT),
    ARC_LAM_OPTION_SHOW_CHAT_MSG						= "Affiche les messages de tchat",
	ARC_LAM_OPTION_SHOW_CHAT_MSG_TT					= "Affiche des messages de tchat si la réparation/recharge de l'arme échoue, etc.",
	ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING			= "Supprime 'Rien ...' Messages",
	ARC_LAM_OPTION_SUPPRESS_CHAT_MSG_NOTHING_TT		= "Ne pas afficher les messages 'Rien chargé' ou 'Rien réparé'",
	ARC_LAM_HEADER_ALERT 							= "Messages à l'écran",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT				= "Affiche l'alerte 'Kit de réparation vide'",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TT			= "Affiche un message d'alerte à l'écran si vos kits de réparation sont vides",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT		= "Afficher 'Kit de répa bientôt vide'",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_REPAIRKIT_TT		= "Affiche un message d'alerte à l'écran si le montant de vos kits de réparation tombe en dessous d'un seuil.\n\nDéfinissez votre seuil sur le curseur à droite!",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH			= "Seuil des kits de réparation",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_TH_TT		= "Définissez une valeur entre 1 et 100 kits de réparation. Si vous quittez le combat et que vos kits de réparation tombent en dessous de cette valeur, vous recevrez un message d'alerte à l'écran.",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN		= "Affiche l'alerte 'Kits de réparation' a la co/reco",
	ARC_LAM_OPTION_ALERT_EMPTY_REPAIRKIT_LOGIN_TT	= "Lorsque vous vous connectez ou effectuez un rechargement:\nAffichez un message d’alerte à l’écran si le montant de vos kits de réparation est inférieur au seuil choisi ou est 0.",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM				= "Afficher '" .. GetString(SI_ITEMTYPE19) .. " Vide'",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TT			= "Affiche un message d'alerte à l'écran si vos gemmes d'âme sont vides",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM			= "Afficher '" .. GetString(SI_ITEMTYPE19) .. " Bientôt vide'",
	ARC_LAM_OPTION_ALERT_SOON_EMPTY_SOULGEM_TT		= "Affiche un message d'alerte à l'écran si la quantité de vos gemmes d'âme tombe en dessous d'un seuil. \n\nRéglez votre seuil sur le curseur à droite!",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH			= GetString(SI_ITEMTYPE19) .. " seuil",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_TH_TT			= "Définissez une valeur entre 1 et 100 gemmes d'âme. Si vous quittez le combat et que vos gemmes d'âme tombent en dessous de cette valeur, vous recevrez un message d'alerte à l'écran.",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN	  		= "Afficher '" .. GetString(SI_ITEMTYPE19) .. "' à la co/reco",
	ARC_LAM_OPTION_ALERT_EMPTY_SOULGEM_LOGIN_TT		= "Lorsque vous vous connectez ou effectuez un rechargement:\nAfficher un message d’alerte à l’écran si votre " .. GetString(SI_ITEMTYPE19) .. " le montant tombe en dessous du seuil choisi ou est déjà 0.",
	ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR	= "Afficher kits de répa laissés au vendeur",
	ARC_LAM_OPTION_SHOW_REPAIR_KITS_LEFT_AT_VENDOR_TT= "Affiche les kits de réparation qui vous restent, si vous parlez à un vendeur, sous la forme d'une petite icône avec le nombre de kits de réparation restants à côté.",
	ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL	= "Utilise un kit pour le niveau d'objet",
	ARC_LAM_OPTION_USE_REPAIR_KITS_FOR_ITEM_LEVEL_TT = "Si vous possédez plusieurs kits de réparation, celui approprié sera utilisé pour le niveau de l'objet (Ex. 'grand kit' pour articles CP 160)",
	ARC_LAM_OPTION_DO_NOT_USE_CROWN_STORE_REPAIR_KITS= "N'utilisez pas de kits de réparation à Couronne",
	ARC_LAM_OPTION_DO_NOT_USE_CROWN_STORE_REPAIR_KITS_TT = "Lorsque ce paramètre est activé, aucun kit de réparation de la boutique à Couronne ne sera utilisé pour les réparations automatiques..",

	ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT			= "Recharge en combat",
	ARC_LAM_OPTION_AUTO_RECHARGE_IN_COMBAT_TT		= "Rechargez automatiquement vos armes également pendant le combat",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE		= "Recharge lors du changement d'arme",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_TT	= "Vérifier et recharger les armes lors d'un changement de paire d'armes .",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_ONLY_IN_COMBAT = "Test de changement d'arme: uniquement en combat",
	ARC_LAM_OPTION_AUTO_RECHARGE_ON_WEAPON_PAIR_CHANGE_ONLY_IN_COMBAT_TT = "Ne faites le test de recharge lors du changement d'arme que si vous êtes en combat ",
	ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT				= "Répare en combat",
	ARC_LAM_OPTION_AUTO_REPAIR_IN_COMBAT_TT		   	= "Réparez automatiquement votre armure également pendant le combat",

--Chat output messages
	ARC_CHATOUTPUT_CHARGED							= GetString(SI_ITEMTRAITTYPE2) .. ": ",
	ARC_CHATOUTPUT_CHARGED_NOTHING	   				= GetString(SI_ITEMTRAITTYPE2) .. " rien: ",
	ARC_CHATOUPUT_NO_CHARGEABLE_WEAPONS				= GetString(SI_SOULGEMITEMCHARGINGREASON1),
	ARC_CHATOUTPUT_REPAIRED							= "Réparé: ",
	ARC_CHATOUTPUT_REPAIRED_NOTHING					= "Rien réparé: ",
	ARC_CHATOUPUT_NO_REPAIRABLE_ARMOR				= GetString(SI_NO_REPAIRS_TO_MAKE),

	ARC_CHATOUPUT_MIN_CHARGE 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_CHARGE_WEAPON_CONFIRM) .. ": ",
	ARC_CHATOUPUT_MIN_CONDITION 						= GetString(SI_GRAPHICSPRESETS0) .. " " .. GetString(SI_REPAIR_SORT_TYPE_CONDITION) .. ": ",
	ARC_CHATOUPUT_INVALID_PERCENTAGE					= "Pourcentage invalide: <<C:1>>, portée: 0-99.",
	ARC_CHATOUPUT_CHARGE								= GetString(SI_CHARGE_WEAPON_CONFIRM) .. " ",
	ARC_CHATOUPUT_REPAIR								= GetString(SI_REPAIR_KIT_TITLE) .. " ",
    ARC_CHATOUPUT_SETTINGS_ENABLED					= GetString(SI_ADDON_MANAGER_ENABLED),
    ARC_CHATOUPUT_SETTINGS_DISABLED					= GetString(SI_CHECK_BUTTON_DISABLED),

	ARC_CHATOUPUT_REPAIRKITS_EMPTY_THRESHOLD			= "Kits de réparation seuil vide: ",
    ARC_CHATOUPUT_SOULGEMS_EMPTY_THRESHOLD			= GetString(SI_ITEMTYPE19) .." seuil vide: ",

--Alert messages
	ARC_ALERT_REPAIRKITS_EMPTY						= "Les kits de réparation sont vides!",
	ARC_ALERT_REPAIRKITS_SOON_EMPTY					= "Les kits de réparation sont bientôt vides! Uniquement <<C:1>> gauche!",
	ARC_ALERT_SOULGEMS_EMPTY							= GetString(SI_ITEMTYPE19) .. " sont vides!",
	ARC_ALERT_SOULGEMS_SOON_EMPTY					= GetString(SI_ITEMTYPE19) .. " sont bientôt vides! Uniquement <<C:1>> gauche!",

--Keybindings
    SI_KEYBINDINGS_CATEGORY_RECHARGE                    = "Auto Recharge",
    SI_BINDING_NAME_RUN_RECHARGE                        = "Déclenchez la recharge automatique et la réparation automatique",
	SI_BINDING_NAME_RUN_REPAIR_SINGLE					= "Déclencher la réparation automatique",
	SI_BINDING_NAME_RUN_RECHARGE_SINGLE					= "Déclencher la recharge automatique",
}

for stringId, stringValue in pairs(strings) do
	ZO_CreateStringId(stringId, stringValue)
	SafeAddVersion(stringId, 1)
end

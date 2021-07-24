/obj/effect/mob_spawn/human/syndicate/engineer
	death = FALSE
	roundstart = FALSE
	random = TRUE
	mob_name = "Syndicate Engineer"
	mob_species = /datum/species/human
	mob_type = /mob/living/carbon/human
	name = "Syndicate Engineer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	short_desc = "You are a contractor employed by the syndicate."
	flavour_text = "You are a contractor employed by the syndicate to fix a ruined Russian outpost. Your job is to make it habitable for a future Syndicate base. DO NOT leave the station, else you will make the Syndicate very angry."
	assignedrole = "Syndicate Engineer"
	outfit = /datum/outfit/Syndicate_engineer

/datum/map_template/ruin/space/fulp/SyndiEng
	name = "Syndicate Engineers"
	id = "Syndi Eng"
	description = "A destroyed Russian outpost"
	suffix = "NEW-syndicate-engineersver2.dmm"

/datum/outfit/Syndicate_engineer
	name = "Syndicate Engineer"
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/syndicate/black/engie
	head = /obj/item/clothing/head/helmet/space/syndicate/black/engie
	mask = /obj/item/clothing/mask/gas/syndicate
	shoes = /obj/item/clothing/shoes/magboots/syndie
	ears = /obj/item/radio/headset/syndicate/alt
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	back = /obj/item/storage/backpack/duffelbag/syndie
	box = /obj/item/storage/box/survival/syndie
	suit_store = /obj/item/tank/internals/oxygen
	belt = /obj/item/storage/belt/utility/syndicate
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/ammo_box/magazine/m9mm


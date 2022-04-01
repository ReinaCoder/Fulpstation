/datum/species/protogen
	name = "Protogen"
	id = "protogen"
	say_mod = "beeps"
	default_color = "00FF00"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER,TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH,TRAIT_GENELESS,TRAIT_STABLEHEART)
	species_traits = list(,IPS,NOEYESPRITES,NOTRANSSTING,TRAIT_RESISTCOLD,NOZOMBIE,TRAIT_PIERCEIMMUNE)
	mutant_bodyparts = list("proto_screen" = "BSOD", "ipc_antenna" = "None", "proto_chassis" = "Morpheus Cyberkinetics(Greyscale)")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	burnmod = 1.5
	heatmod = 1.2
	brutemod = 1.5
	exotic_blood = /datum/reagent/fuel/oil
	species_language_holder = /datum/language_holder/protogen
	var/datum/action/innate/monitor_change/screen
	var/saved_screen = "Blank"

/datum/species/protogen/spec_life(mob/living/carbon/human/H)
	if(H.stat == SOFT_CRIT || H.stat == HARD_CRIT)
		H.adjustFireLoss(1)
		H.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(H, "<span class='warning'>Alert: Critical damage taken! Cooling systems failing!</span>")
			do_sparks(3, TRUE, H)

/datum/species/protogen/spec_death(gibbed, mob/living/carbon/human/C)
	. = ..()
	saved_screen = C.dna.features["proto_screen"]
	C.dna.features["proto_screen"] = "BSOD"
	C.update_body()
	sleep(3 SECONDS)
	C.dna.features["proto_screen"] = null // Turns off their monitor on death.
	C.update_body()

/datum/species/protogen/on_species_gain(mob/living/carbon/human/proto)
	. = ..()
	var/obj/item/organ/appendix/appendix = proto.getorganslot(ORGAN_SLOT_APPENDIX)
	if(appendix)
		appendix.Remove(proto)
		qdel(appendix)
	if(!screen)
		screen = new
		screen.Grant(proto)
	var/chassis = proto.dna.features["proto_chassis"]
	if(!chassis)
		return
	var/datum/sprite_accessory/proto_chassis/chassis_of_choice = GLOB.proto_chassis_list[chassis]
	if(chassis_of_choice)
		limbs_id = chassis_of_choice.icon_state
		if(chassis_of_choice.color_src)
			species_traits += MUTCOLORS
		proto.update_body()

/datum/species/protogen/on_species_loss(mob/living/carbon/human/proto)
	. = ..()
	if(screen)
		screen.Remove(proto)
	..()

/datum/action/innate/monitor_change
	name = "Screen Change"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/monitor_change/Activate()
	var/mob/living/carbon/human/protogen = owner
	var/new_proto_screen = input(usr, "Choose your character's screen:", "Monitor Display") as null|anything in GLOB.proto_screens_list
	if(!new_proto_screen)
		return
	protogen.dna.features["proto_screen"] = new_proto_screen
	protogen.update_body()

/datum/species/protogen/check_roundstart_eligible()
	return TRUE

/datum/language_holder/protogen // Common + Machine
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/machine = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/machine = list(LANGUAGE_ATOM))

/datum/species/protogen/get_features()
	var/list/features = ..()
	features += "feature_beefcolor"
	features += "feature_beefeyes"
	features += "feature_beefmouth"
	features += "feature_beef_trauma"

	return features

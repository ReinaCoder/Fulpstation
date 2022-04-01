/datum/preference/choiced/proto_chassis
	savefile_key = "feature_proto_chassis"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Protogen Chassis"
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "proto_chassis"

/datum/preference/choiced/proto_chassis/init_possible_values()
	var/list/values = list()

	var/icon/proto_body = icon('icons/blanks/32x32.dmi', "nothing")

	proto_body.Blend(icon('icons/mob/moth_wings.dmi', "m_moth_wings_plain_BEHIND"), ICON_OVERLAY)

	var/list/body_parts = list(
		BODY_ZONE_HEAD,
		BODY_ZONE_CHEST,
		BODY_ZONE_L_ARM,
		BODY_ZONE_R_ARM,
		BODY_ZONE_R_LEG,
		BODY_ZONE_L_LEG
	)

	for (var/body_part in body_parts)
		proto_body.Blend(icon('fulp_modules/features/species/icons/', "proto_[body_part][gender]"), ICON_OVERLAY)

	for (var/markings_name in GLOB.proto_chassis_list)
		var/datum/sprite_accessory/markings = GLOB.proto_chassis_list[markings_name]
		var/icon/icon_with_markings = new(proto_body)

		if (markings_name != "None")
			for (var/body_part in body_parts)
				var/icon/body_part_icon = icon(markings.icon, "[markings.icon_state]_[body_part]")
				body_part_icon.Crop(1, 1, 32, 32)
				icon_with_markings.Blend(body_part_icon, ICON_OVERLAY)


		// Zoom in on the top of the head and the chest
		icon_with_markings.Scale(64, 64)
		icon_with_markings.Crop(15, 64, 15 + 31, 64 - 31)

		values[markings.name] = icon_with_markings

	return values

/datum/preference/choiced/proto_chassis/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["proto_chassis"] = value

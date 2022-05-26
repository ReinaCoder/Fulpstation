/// Look up levels[z].traits[trait]
/datum/controller/subsystem/mapping/proc/level_trait(z, trait)
	if (!isnum(z) || z < 1)
		return null
	if (z_list)
		if (z > z_list.len)
			stack_trace("Unmanaged z-level [z]! maxz = [world.maxz], z_list.len = [z_list.len]")
			return list()
		var/datum/space_level/S = get_level(z)
		return S.traits[trait]
	else
		var/list/default = DEFAULT_MAP_TRAITS
		if (z > default.len)
			stack_trace("Unmanaged z-level [z]! maxz = [world.maxz], default.len = [default.len]")
			return list()
		return default[z][DL_TRAITS][trait]

/// Check if levels[z] has any of the specified traits
/datum/controller/subsystem/mapping/proc/level_has_any_trait(z, list/traits)
	for (var/I in traits)
		if (level_trait(z, I))
			return TRUE
	return FALSE

/// Check if levels[z] has all of the specified traits
/datum/controller/subsystem/mapping/proc/level_has_all_traits(z, list/traits)
	for (var/I in traits)
		if (!level_trait(z, I))
			return FALSE
	return TRUE

/// Get a list of all z which have the specified trait
/datum/controller/subsystem/mapping/proc/levels_by_trait(trait)
	var/list/final_return = list()
	for(var/datum/space_level/level as anything in z_list)
		if (level.traits[trait])
			final_return += level.z_value
	return final_return

/// Get a list of all z which have any of the specified traits
/datum/controller/subsystem/mapping/proc/levels_by_any_trait(list/traits)
	var/list/final_return = list()
	for(var/datum/space_level/level as anything in z_list)
		for (var/trait in traits)
			if (level.traits[trait])
				final_return += level.z_value
				break
	return final_return

/// Get a list of all z which have all of the specified traits
/datum/controller/subsystem/mapping/proc/levels_by_all_traits(list/traits)
	var/list/final_return = list()
	for(var/datum/space_level/level as anything in z_list)
		if(level_has_all_traits(level.z_value, traits))
			final_return += level.z_value
	return final_return

/// Attempt to get the turf below the provided one according to Z traits
/datum/controller/subsystem/mapping/proc/get_turf_below(turf/T)
	if (!T)
		return
	var/offset = level_trait(T.z, ZTRAIT_DOWN)
	if (!offset)
		return
	return locate(T.x, T.y, T.z + offset)

/// Attempt to get the turf above the provided one according to Z traits
/datum/controller/subsystem/mapping/proc/get_turf_above(turf/T)
	if (!T)
		return
	var/offset = level_trait(T.z, ZTRAIT_UP)
	if (!offset)
		return
	return locate(T.x, T.y, T.z + offset)

/// Prefer not to use this one too often
/datum/controller/subsystem/mapping/proc/get_station_center()
	var/station_z = levels_by_trait(ZTRAIT_STATION)[1]
	return locate(round(world.maxx * 0.5, 1), round(world.maxy * 0.5, 1), station_z)

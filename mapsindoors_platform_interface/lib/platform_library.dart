library mapsindoors_platform;

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'directionsrenderer_platform_interface.dart';
part 'directionsservice_platform_interface.dart';
part 'display_rule_platform_interface.dart';
part 'mapcontrol_platform_interface.dart';
part 'mapsindoors_platform_interface.dart';
part 'util_platform_interface.dart';

part 'src/directionsrenderer_method_channel.dart';
part 'src/directionsservice_method_channel.dart';
part 'src/display_rule_method_channel.dart';
part 'src/mapcontrol_method_channel.dart';
part 'src/mapsindoors_method_channel.dart';
part 'src/util_method_channel.dart';

part 'src/util.dart';

part 'models/geometries/mp_geometry.dart';
part 'models/geometries/mp_bounds.dart';
part 'models/geometries/mp_point.dart';
part 'models/geometries/mp_polygon.dart';
part 'models/geometries/mp_multi_polygon.dart';

part 'models/entities/mp_entity.dart';
part 'models/entities/mp_venue.dart';
part 'models/entities/mp_building.dart';
part 'models/entities/mp_floor.dart';
part 'models/entities/mp_location.dart';

part 'models/enums/mp_collision_handling.dart';
part 'models/enums/mp_location_propery_names.dart';
part 'models/enums/mp_location_type.dart';
part 'models/enums/mp_solution_display_rule.dart';
part 'models/enums/mp_camera_event.dart';
part 'models/enums/mp_camera_view_fit_mode.dart';
part 'models/enums/live_data_domain_types.dart';
part 'models/enums/mp_highway.dart';

part 'models/listeners/mp_camera_event_listener.dart';
part 'models/listeners/on_building_found_at_camera_target_listener.dart';
part 'models/listeners/on_floor_selection_changed_listener.dart';
part 'models/listeners/on_floor_update_listener.dart';
part 'models/listeners/on_location_selected_listener.dart';
part 'models/listeners/on_map_click_listener.dart';
part 'models/listeners/on_mapsindoors_ready_listener.dart';
part 'models/listeners/on_marker_click_listener.dart';
part 'models/listeners/on_marker_info_window_click_listener.dart';
part 'models/listeners/on_venue_found_at_camera_target_listener.dart';
part 'models/listeners/on_position_update_listener.dart';
part 'models/listeners/on_leg_selected_listener.dart';
part 'models/listeners/on_live_location_update_listener.dart';

part 'models/routing/mp_route.dart';
part 'models/routing/mp_route_leg.dart';
part 'models/routing/mp_route_step.dart';
part 'models/routing/mp_route_coordinate.dart';
part 'models/routing/mp_route_property.dart';

part 'models/map_control_interface.dart';
part 'models/mp_display_rule.dart';
part 'models/mp_error.dart';
part 'models/mp_filter.dart';
part 'models/mp_query.dart';
part 'models/mp_floor_selector_interface.dart';
part 'models/mp_map_behavior.dart';
part 'models/mp_position_provider_interface.dart';
part 'models/mp_position_result_interface.dart';
part 'models/mp_building_info.dart';
part 'models/mp_venue_info.dart';
part 'models/mp_property_data.dart';
part 'models/mp_solution.dart';
part 'models/mp_solution_config.dart';
part 'models/mp_settings_3d.dart';
part 'models/mp_category.dart';
part 'models/mp_data_field.dart';
part 'models/mp_geocode_result.dart';
part 'models/mp_user_role.dart';
part 'models/mp_map_config.dart';
part 'models/mp_icon_size.dart';
part 'models/mp_map_style.dart';
part 'models/mp_route_result.dart';

part 'models/map/mp_camera_update.dart';
part 'models/map/mp_camera_position.dart';

part 'models/collections/mp_collection.dart';
part 'models/collections/mp_building_collection.dart';
part 'models/collections/mp_category_collection.dart';
part 'models/collections/mp_user_role_collection.dart';
part 'models/collections/mp_venue_collection.dart';

part of 'package:mapsindoors_platform_interface/platform_library.dart';

/// Different ways the camera can fit a route inside the screen
/// 
/// [northAligned] : The camera will point north
/// 
/// [firstStepAligned] : The camera will be aligned with the direction of the first step
/// 
/// [startToEndAligned] : The camera will point in the same direction as a line that 
/// goes directly from the origin to the destination
enum MPCameraViewFitMode { northAligned, firstStepAligned, startToEndAligned }

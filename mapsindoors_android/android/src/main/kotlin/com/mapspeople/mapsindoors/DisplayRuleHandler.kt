package com.mapspeople.mapsindoors

import com.google.gson.Gson
import com.mapsindoors.core.*
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class DisplayRuleHandler(messenger: BinaryMessenger) : MethodCallHandler {
    private val displayRuleChannel: MethodChannel
    private val gson = Gson()
    init {
        displayRuleChannel = MethodChannel(messenger, "DisplayRuleMethodChannel")
        displayRuleChannel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val id = call.argument<String>("id")!!
        val dr: MPDisplayRule? = when (id) {
            "buildingOutline" -> MapsIndoors.getDisplayRule(MPSolutionDisplayRule.BUILDING_OUTLINE)
            "selectionHighlight" -> MapsIndoors.getDisplayRule(MPSolutionDisplayRule.SELECTION_HIGHLIGHT)
            "positionIndicator" -> MapsIndoors.getDisplayRule(MPSolutionDisplayRule.POSITION_INDICATOR)
            else -> MapsIndoors.getDisplayRule(id)
        }

        fun error(details: Any? = null) {
            result.error("-1", "Argument was null", details)
        }
        fun success(ret : Any? = "success") {
            result.success(ret)
        }

        val method = call.method.drop(4)

        dr?.apply {
            when (method) {
                "isVisible" -> success(isVisible)
                "setVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "getIconSize" -> success(gson.toJson(iconSize))
                "getIconUrl" -> success(iconUrl)
                "getLabel" -> success(label)
                "getLabelMaxWidth" -> success(labelMaxWidth)
                "getLabelZoomFrom" -> success(labelZoomFrom)
                "getLabelZoomTo" -> success(labelZoomTo)
                "getModel2DBearing" -> success(model2DBearing)
                "getModel2DHeightMeters" -> success(model2DHeightMeters)
                "getModel2DModel" -> success(model2DModel)
                "getModel2DZoomTo" -> success(model2DZoomTo)
                "getModel2DWidthMeters" -> success(model2DWidthMeters)
                "getModel2DZoomFrom" -> success(model2DZoomFrom)
                "getPolygonFillColor" -> success(polygonFillColor)
                "getPolygonFillOpacity" -> success(polygonFillOpacity)
                "getPolygonZoomTo" -> success(polygonZoomTo)
                "getPolygonStrokeColor" -> success(polygonStrokeColor)
                "getPolygonStrokeOpacity" -> success(polygonStrokeOpacity)
                "getPolygonStrokeWidth" -> success(polygonStrokeWidth)
                "getPolygonZoomFrom" -> success(polygonZoomFrom)
                "getZoomFrom" -> success(zoomFrom)
                "getZoomTo" -> success(zoomTo)
                "isIconVisible" -> success(isIconVisible)
                "isLabelVisible" -> success(isLabelVisible)
                "isModel2DVisible" -> success(isModel2DVisible)
                "isPolygonVisible" -> success(isPolygonVisible)
                "isValid" -> success(isValid)
                "reset" -> {
                    reset()
                    success()
                }
                "setIcon" -> {
                    val iconUrl = call.argument<String>("url")
                    if (iconUrl != null) {
                        setIcon(iconUrl)
                        success()
                    } else {
                        error()
                    }
                }
                "setIconVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isIconVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "setIconSize" -> {
                    val size = gson.fromJson(call.argument<String>("size"), MPIconSize::class.java)
                    if (size != null) {
                        setIconSize(size.width, size.height)
                        success()
                    } else {
                        error()
                    }
                }
                "setLabel" -> {
                    val label = call.argument<String>("label")
                    if (label != null) {
                        dr.label = label
                        success()
                    } else {
                        error()
                    }
                }
                "setLabelMaxWidth" -> {
                    val maxWidth = call.argument<Int>("maxWidth")
                    if (maxWidth != null) {
                        labelMaxWidth = maxWidth
                        success()
                    } else {
                        error()
                    }
                }
                "setLabelVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isLabelVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "setLabelZoomFrom" -> {
                    val zoomFrom = call.argument<Double>("zoomFrom")
                    if (zoomFrom != null) {
                        labelZoomFrom = zoomFrom.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setLabelZoomTo" -> {
                    val zoomTo = call.argument<Double>("zoomTo")
                    if (zoomTo != null) {
                        labelZoomTo = zoomTo.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DBearing" -> {
                    val bearing = call.argument<Double>("bearing")
                    if (bearing != null) {
                        model2DBearing = bearing
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DModel" -> {
                    val model = call.argument<String>("model")
                    if (model != null) {
                        //TODO: re-enable in 4.1.0 (or 4.0.6 (or 5.0.0))
                        //model2DModel = model
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DHeightMeters" -> {
                    val height = call.argument<Double>("height")
                    if (height != null) {
                        model2DHeightMeters = height
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isModel2DVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DWidthMeters" -> {
                    val width = call.argument<Double>("width")
                    if (width != null) {
                        model2DWidthMeters = width
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DZoomFrom" -> {
                    val zoomFrom = call.argument<Double>("zoomFrom")
                    if (zoomFrom != null) {
                        model2DZoomFrom = zoomFrom.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setModel2DZoomTo" -> {
                    val zoomTo = call.argument<Double>("zoomTo")
                    if (zoomTo != null) {
                        model2DZoomTo =  zoomTo.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonFillColor" -> {
                    val color = call.argument<String>("color")
                    if (color != null) {
                        polygonFillColor = color
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonFillOpacity" -> {
                    val opacity = call.argument<Double>("opacity")
                    if (opacity != null) {
                        polygonFillOpacity = opacity.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonStrokeColor" -> {
                    val color = call.argument<String>("color")
                    if (color != null) {
                        polygonStrokeColor = color
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonStrokeOpacity" -> {
                    val opacity = call.argument<Double>("opacity")
                    if (opacity != null) {
                        polygonStrokeOpacity = opacity.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonStrokeWidth" -> {
                    val width = call.argument<Double>("width")
                    if (width != null) {
                        polygonStrokeWidth = width.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isPolygonVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonZoomFrom" -> {
                    val zoomFrom = call.argument<Double>("zoomFrom")
                    if (zoomFrom != null) {
                        polygonZoomFrom = zoomFrom.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setPolygonZoomTo" -> {
                    val zoomTo = call.argument<Double>("zoomTo")
                    if (zoomTo != null) {
                        polygonZoomTo = zoomTo.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "getExtrusionColor" -> success(extrusionColor)
                "getExtrusionHeight" -> success(extrusionHeight)
                "getExtrusionZoomFrom" -> success(extrusionZoomFrom)
                "getExtrusionZoomTo" -> success(extrusionZoomTo)
                "getWallColor" -> success(wallColor)
                "getWallHeight" -> success(wallHeight)
                "getWallZoomFrom" -> success(wallZoomFrom)
                "getWallZoomTo" -> success(wallZoomTo)
                "isExtrusionVisible" -> success(isExtrusionVisible)
                "isWallVisible" -> success(isWallVisible)
                "setExtrusionColor" -> {
                    val color = call.argument<String>("color")
                    if (color != null) {
                        extrusionColor = color
                        success()
                    } else {
                        error()
                    }
                }
                "setExtrusionHeight" -> {
                    val height = call.argument<Double>("height")
                    if (height != null) {
                        extrusionHeight = height.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setExtrusionVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isExtrusionVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "setExtrusionZoomFrom" -> {
                    val zoomFrom = call.argument<Double>("zoomFrom")
                    if (zoomFrom != null) {
                        extrusionZoomFrom = zoomFrom.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setExtrusionZoomTo" -> {
                    val zoomTo = call.argument<Double>("zoomTo")
                    if (zoomTo != null) {
                        extrusionZoomTo = zoomTo.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setWallColor" -> {
                    val color = call.argument<String>("color")
                    if (color != null) {
                        wallColor = color
                        success()
                    } else {
                        error()
                    }
                }
                "setWallHeight" -> {
                    val height = call.argument<Double>("height")
                    if (height != null) {
                        wallHeight = height.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setWallVisible" -> {
                    val visible = call.argument<Boolean>("visible")
                    if (visible != null) {
                        isWallVisible = visible
                        success()
                    } else {
                        error()
                    }
                }
                "setWallZoomFrom" -> {
                    val zoomFrom = call.argument<Double>("zoomFrom")
                    if (zoomFrom != null) {
                        wallZoomFrom = zoomFrom.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setWallZoomTo" -> {
                    val zoomTo = call.argument<Double>("zoomTo")
                    if (zoomTo != null) {
                        wallZoomTo = zoomTo.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setZoomFrom" -> {
                    val zoomFromArg = call.argument<Double>("zoomFrom")
                    if (zoomFromArg != null) {
                        zoomFrom = zoomFromArg.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                "setZoomTo" -> {
                    val zoomToArg = call.argument<Double>("zoomTo")
                    if (zoomToArg != null) {
                        zoomTo = zoomToArg.toFloat()
                        success()
                    } else {
                        error()
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
            return@onMethodCall
        }
        success(null)
    }
}
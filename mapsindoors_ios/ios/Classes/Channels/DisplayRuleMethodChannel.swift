//
//  DisplayRuleMethodChannel.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 21/02/2023.
//

import Foundation
import Flutter
import UIKit
import MapsIndoors
import MapsIndoorsCore
import MapsIndoorsCodable
import MapsIndoorsGoogleMaps
import GoogleMaps

public class DisplayRuleMethodChannel: NSObject {
    
    enum Methods: String {
        case DRU_isVisible
        case DRU_setVisible
        case DRU_getIconSize
        case DRU_getIconUrl
        case DRU_getLabel
        case DRU_getLabelMaxWidth
        case DRU_getLabelZoomFrom
        case DRU_getLabelZoomTo
        case DRU_getModel2DBearing
        case DRU_getModel2DHeightMeters
        case DRU_getModel2DModel
        case DRU_getModel2DZoomTo
        case DRU_getModel2DWidthMeters
        case DRU_getModel2DZoomFrom
        case DRU_getPolygonFillColor
        case DRU_getPolygonFillOpacity
        case DRU_getPolygonZoomTo
        case DRU_getPolygonStrokeColor
        case DRU_getPolygonStrokeOpacity
        case DRU_getPolygonStrokeWidth
        case DRU_getPolygonZoomFrom
        case DRU_getZoomFrom
        case DRU_getZoomTo
        case DRU_isIconVisible
        case DRU_isLabelVisible
        case DRU_isModel2DVisible
        case DRU_isPolygonVisible
        case DRU_isValid
        case DRU_reset
        case DRU_setIcon
        case DRU_setIconVisible
        case DRU_setIconSize
        case DRU_setLabel
        case DRU_setLabelMaxWidth
        case DRU_setLabelVisible
        case DRU_setLabelZoomFrom
        case DRU_setLabelZoomTo
        case DRU_setModel2DBearing
        case DRU_setModel2DModel
        case DRU_setModel2DHeightMeters
        case DRU_setModel2DVisible
        case DRU_setModel2DWidthMeters
        case DRU_setModel2DZoomFrom
        case DRU_setModel2DZoomTo
        case DRU_setPolygonFillColor
        case DRU_setPolygonFillOpacity
        case DRU_setPolygonStrokeColor
        case DRU_setPolygonStrokeOpacity
        case DRU_setPolygonStrokeWidth
        case DRU_setPolygonVisible
        case DRU_setPolygonZoomFrom
        case DRU_setPolygonZoomTo
        case DRU_getExtrusionColor
        case DRU_getExtrusionHeight
        case DRU_getExtrusionZoomFrom
        case DRU_getExtrusionZoomTo
        case DRU_getWallColor
        case DRU_getWallHeight
        case DRU_getWallZoomFrom
        case DRU_getWallZoomTo
        case DRU_isExtrusionVisible
        case DRU_isWallVisible
        case DRU_setExtrusionColor
        case DRU_setExtrusionHeight
        case DRU_setExtrusionVisible
        case DRU_setExtrusionZoomFrom
        case DRU_setExtrusionZoomTo
        case DRU_setWallColor
        case DRU_setWallHeight
        case DRU_setWallVisible
        case DRU_setWallZoomFrom
        case DRU_setWallZoomTo
        case DRU_setZoomFrom
        case DRU_setZoomTo
        
        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult) -> Void

            switch self {
            case .DRU_isVisible:                    runner = isVisible
            case .DRU_setVisible:                   runner = setVisible
            case .DRU_getIconSize:                  runner = getIconSize
            case .DRU_getIconUrl:                   runner = getIconUrl
            case .DRU_getLabel:                     runner = getLabel
            case .DRU_getLabelMaxWidth:             runner = getLabelMaxWidth
            case .DRU_getLabelZoomFrom:             runner = getLabelZoomFrom
            case .DRU_getLabelZoomTo:               runner = getLabelZoomTo
            case .DRU_getModel2DBearing:            runner = getModel2DBearing
            case .DRU_getModel2DHeightMeters:       runner = getModel2DHeightMeters
            case .DRU_getModel2DModel:              runner = getModel2DModel
            case .DRU_getModel2DZoomTo:             runner = getModel2DZoomTo
            case .DRU_getModel2DWidthMeters:        runner = getModel2DWidthMeters
            case .DRU_getModel2DZoomFrom:           runner = getModel2DZoomFrom
            case .DRU_getPolygonFillColor:          runner = getPolygonFillColor
            case .DRU_getPolygonFillOpacity:        runner = getPolygonFillOpacity
            case .DRU_getPolygonZoomTo:             runner = getPolygonZoomTo
            case .DRU_getPolygonStrokeColor:        runner = getPolygonStrokeColor
            case .DRU_getPolygonStrokeOpacity:      runner = getPolygonStrokeOpacity
            case .DRU_getPolygonStrokeWidth:        runner = getPolygonStrokeWidth
            case .DRU_getPolygonZoomFrom:           runner = getPolygonZoomFrom
            case .DRU_getZoomFrom:                  runner = getZoomFrom
            case .DRU_getZoomTo:                    runner = getZoomTo
            case .DRU_isIconVisible:                runner = isIconVisible
            case .DRU_isLabelVisible:               runner = isLabelVisible
            case .DRU_isModel2DVisible:             runner = isModel2DVisible
            case .DRU_isPolygonVisible:             runner = isPolygonVisible
            case .DRU_isValid:                      runner = isValid
            case .DRU_reset:                        runner = reset
            case .DRU_setIcon:                      runner = setIcon
            case .DRU_setIconVisible:               runner = setIconVisible
            case .DRU_setIconSize:                  runner = setIconSize
            case .DRU_setLabel:                     runner = setLabel
            case .DRU_setLabelMaxWidth:             runner = setLabelMaxWidth
            case .DRU_setLabelVisible:              runner = setLabelVisible
            case .DRU_setLabelZoomFrom:             runner = setLabelZoomFrom
            case .DRU_setLabelZoomTo:               runner = setLabelZoomTo
            case .DRU_setModel2DBearing:            runner = setModel2DBearing
            case .DRU_setModel2DModel:              runner = setModel2DModel
            case .DRU_setModel2DHeightMeters:       runner = setModel2DHeightMeters
            case .DRU_setModel2DVisible:            runner = setModel2DVisible
            case .DRU_setModel2DWidthMeters:        runner = setModel2DWidthMeters
            case .DRU_setModel2DZoomFrom:           runner = setModel2DZoomFrom
            case .DRU_setModel2DZoomTo:             runner = setModel2DZoomTo
            case .DRU_setPolygonFillColor:          runner = setPolygonFillColor
            case .DRU_setPolygonFillOpacity:        runner = setPolygonFillOpacity
            case .DRU_setPolygonStrokeColor:        runner = setPolygonStrokeColor
            case .DRU_setPolygonStrokeOpacity:      runner = setPolygonStrokeOpacity
            case .DRU_setPolygonStrokeWidth:        runner = setPolygonStrokeWidth
            case .DRU_setPolygonVisible:            runner = setPolygonVisible
            case .DRU_setPolygonZoomFrom:           runner = setPolygonZoomFrom
            case .DRU_setPolygonZoomTo:             runner = setPolygonZoomTo
            case .DRU_getExtrusionColor:            runner = getExtrusionColor
            case .DRU_getExtrusionHeight:           runner = getExtrusionHeight
            case .DRU_getExtrusionZoomFrom:         runner = getExtrusionZoomFrom
            case .DRU_getExtrusionZoomTo:           runner = getExtrusionZoomTo
            case .DRU_getWallColor:                 runner = getWallColor
            case .DRU_getWallHeight:                runner = getWallHeight
            case .DRU_getWallZoomFrom:              runner = getWallZoomFrom
            case .DRU_getWallZoomTo:                runner = getWallZoomTo
            case .DRU_isExtrusionVisible:           runner = isExtrusionVisible
            case .DRU_isWallVisible:                runner = isWallVisible
            case .DRU_setExtrusionColor:            runner = setExtrusionColor
            case .DRU_setExtrusionHeight:           runner = setExtrusionHeight
            case .DRU_setExtrusionVisible:          runner = setExtrusionVisible
            case .DRU_setExtrusionZoomFrom:         runner = setExtrusionZoomFrom
            case .DRU_setExtrusionZoomTo:           runner = setExtrusionZoomTo
            case .DRU_setWallColor:                 runner = setWallColor
            case .DRU_setWallHeight:                runner = setWallHeight
            case .DRU_setWallVisible:               runner = setWallVisible
            case .DRU_setWallZoomFrom:              runner = setWallZoomFrom
            case .DRU_setWallZoomTo:                runner = setWallZoomTo
            case .DRU_setZoomFrom:                  runner = setZoomFrom
            case .DRU_setZoomTo:                    runner = setZoomTo
            }
            
            runner(arguments, mapsIndoorsData, result)
        }
       
        func getDisplayRule(id: String) -> MPDisplayRule? {
            let location = MPMapsIndoors.shared.locationWith(locationId: id)
            if (location != nil) {
                return MPMapsIndoors.shared.displayRuleFor(location: location!)
            }else {
                if (isSolutionDisplayRule(displayRuleId: id)) {
                    //TODO: Discuss MPDisplayRuleType enum, being int values instead of string. Could create a copy with String values in flutter project for logic
                    return nil//MPMapsIndoors.shared.displayRuleFor(id: MPDisplayRuleType)
                }else {
                    return MPMapsIndoors.shared.displayRuleFor(type: id)
                }
            }
        }
        
        func hexStringFromColor(color: UIColor) -> String {
            let components = color.cgColor.components
            let r: CGFloat = components?[0] ?? 0.0
            let g: CGFloat = components?[1] ?? 0.0
            let b: CGFloat = components?[2] ?? 0.0

            let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
            print(hexString)
            return hexString
         }
        
        func isSolutionDisplayRule(displayRuleId: String) -> Bool {
            return false
        }
        
        func isVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.visible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isVisible", details: nil))
            }
        }
        
        func setVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setVisible", details: nil))
                    return
                }
                displayRule?.visible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setVisible", details: nil))
            }
        }
        
        func getIconSize(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getIconSize", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                let data = try? JSONEncoder().encode(MPIconSizeCodable(withCGSize: displayRule!.iconSize))
                if (data != nil) {
                    let iconSizeString = String(data: data!, encoding: String.Encoding.utf8)
                    result(iconSizeString)
                }
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getIconSize", details: nil))
            }
        }
        
        func getIconUrl(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getIconUrl", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.iconURL?.absoluteString)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getIconUrl", details: nil))
            }
        }
        
        func getLabel(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getLabel", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.label)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getLabel", details: nil))
            }
        }
        
        func getLabelMaxWidth(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getLabelMaxWidth", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.labelMaxWidth)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getLabelMaxWidth", details: nil))
            }
        }
        
        func getLabelZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getLabelZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.labelZoomFrom)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getLabelZoomFrom", details: nil))
            }
        }
        
        func getLabelZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getLabelZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.labelZoomTo)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getLabelZoomTo", details: nil))
            }
        }
        
        func getModel2DBearing(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getModel2DBearing", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DBearing)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getModel2DBearing", details: nil))
            }
        }
        
        func getModel2DHeightMeters(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getModel2DHeightMeters", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DHeightMeters)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getModel2DHeightMeters", details: nil))
            }
        }
        
        func getModel2DModel(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getModel2DModel", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DModel)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getModel2DModel", details: nil))
            }
        }
        
        func getModel2DZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getModel2DZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DZoomTo)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getModel2DZoomTo", details: nil))
            }
        }
        
        func getModel2DWidthMeters(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getModel2DWidthMeters", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DWidthMeters)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getModel2DWidthMeters", details: nil))
            }
        }
        
        func getModel2DZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getModel2DZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DZoomTo)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getModel2DZoomFrom", details: nil))
            }
        }
        
        func getPolygonFillColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonFillColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(hexStringFromColor(color: displayRule!.polygonFillColor!))
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonFillColor", details: nil))
            }
        }
        
        func getPolygonFillOpacity(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonFillOpacity", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.polygonFillOpacity)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonFillOpacity", details: nil))
            }
        }
        
        func getPolygonZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.polygonZoomTo)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonZoomTo", details: nil))
            }
        }
        
        func getPolygonStrokeColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonStrokeColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(hexStringFromColor(color: displayRule!.polygonStrokeColor!))
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonStrokeColor", details: nil))
            }
        }
        
        func getPolygonStrokeOpacity(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonStrokeOpacity", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.polygonStrokeOpacity)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonStrokeOpacity", details: nil))
            }
        }
        
        func getPolygonStrokeWidth(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonStrokeWidth", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.polygonStrokeWidth)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonStrokeWidth", details: nil))
            }
        }
        
        func getPolygonZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getPolygonZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.polygonZoomFrom)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getPolygonZoomFrom", details: nil))
            }
        }
        
        func getZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.zoomFrom)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getZoomFrom", details: nil))
            }
        }
        
        func getZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.zoomTo)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getZoomTo", details: nil))
            }
        }
        
        func isIconVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isIconVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.iconVisible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isIconVisible", details: nil))
            }
        }
        
        func isLabelVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isLabelVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.labelVisible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isLabelVisible", details: nil))
            }
        }
        
        func isModel2DVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isModel2DVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.model2DVisible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isModel2DVisible", details: nil))
            }
        }
        
        func isPolygonVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isPolygonVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.polygonVisible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isPolygonVisible", details: nil))
            }
        }
        
        func isValid(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isValid", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(true)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isValid", details: nil))
            }
        }
        
        func reset(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_reset", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                displayRule!.reset()
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_reset", details: nil))
            }
        }
        
        func setIcon(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setIcon", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let url = arguments?["url"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setIcon", details: nil))
                    return
                }
                displayRule?.iconURL = URL(string: url)
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setIcon", details: nil))
            }
        }
        
        func setIconVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setIconVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setIconVisible", details: nil))
                    return
                }
                displayRule?.iconVisible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setIconVisible", details: nil))
            }
        }
        
        func setIconSize(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setIconSize", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let iconSizeString = arguments?["size"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setIconSize", details: nil))
                    return
                }
                let iconSize = try? JSONDecoder().decode(MPIconSizeCodable.self, from: Data(iconSizeString.utf8))
                if (iconSize != nil) {
                    displayRule?.iconSize = CGSize(width: iconSize!.width!, height: iconSize!.height!)
                    result(nil)
                }else {
                    result(FlutterError(code: "Could not parse iconSize", message: "DRU_setIconSize", details: nil))
                }
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setIconSize", details: nil))
            }
        }
        
        func setLabel(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setLabel", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let label = arguments?["label"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setLabel", details: nil))
                    return
                }
                displayRule?.label = label
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setLabel", details: nil))
            }
        }
        
        func setLabelMaxWidth(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setLabelMaxWidth", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let maxWidth = arguments?["maxWidth"] as? UInt else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setLabelMaxWidth", details: nil))
                    return
                }
                displayRule?.labelMaxWidth = maxWidth
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setLabelMaxWidth", details: nil))
            }
        }
        
        func setLabelVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setLabelVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setLabelVisible", details: nil))
                    return
                }
                displayRule?.labelVisible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setLabelVisible", details: nil))
            }
        }
        
        func setLabelZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setLabelZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomFrom = arguments?["zoomFrom"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setLabelZoomFrom", details: nil))
                    return
                }
                displayRule?.labelZoomFrom = zoomFrom
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setLabelZoomFrom", details: nil))
            }
        }
        
        func setLabelZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setLabelZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomTo = arguments?["zoomTo"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setLabelZoomTo", details: nil))
                    return
                }
                displayRule?.labelZoomTo = zoomTo
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setLabelZoomTo", details: nil))
            }
        }
        
        func setModel2DBearing(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setModel2DBearing", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let bearing = arguments?["bearing"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setModel2DBearing", details: nil))
                    return
                }
                displayRule?.model2DBearing = bearing
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setModel2DBearing", details: nil))
            }
        }
        
        func setModel2DModel(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setModel2DModel", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let model = arguments?["model"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setModel2DModel", details: nil))
                    return
                }
                displayRule?.model2DModel = model
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setModel2DModel", details: nil))
            }
        }
        
        func setModel2DHeightMeters(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setModel2DHeightMeters", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let height = arguments?["height"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setModel2DHeightMeters", details: nil))
                    return
                }
                displayRule?.model2DHeightMeters = height
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setModel2DHeightMeters", details: nil))
            }
        }
        
        func setModel2DVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "setModel2DVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "setModel2DVisible", details: nil))
                    return
                }
                displayRule?.model2DVisible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setModel2DVisible", details: nil))
            }
        }
        
        func setModel2DWidthMeters(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setModel2DWidthMeters", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let width = arguments?["width"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setModel2DWidthMeters", details: nil))
                    return
                }
                displayRule?.model2DWidthMeters = width
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setModel2DWidthMeters", details: nil))
            }
        }
        
        func setModel2DZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: nil, details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomFrom = arguments?["zoomFrom"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "setModel2DZoomFrom", details: nil))
                    return
                }
                displayRule?.model2DZoomFrom = zoomFrom
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "setModel2DZoomFrom", details: nil))
            }
        }
        
        func setModel2DZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setModel2DZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomTo = arguments?["zoomTo"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setModel2DZoomTo", details: nil))
                    return
                }
                displayRule?.model2DZoomTo = zoomTo
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setModel2DZoomTo", details: nil))
            }
        }
        
        func setPolygonFillColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonFillColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard var color = arguments?["color"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonFillColor", details: nil))
                    return
                }
                displayRule?.polygonFillColor = UIColor(fromHexString: color)
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonFillColor", details: nil))
            }
        }
        
        func setPolygonFillOpacity(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonFillOpacity", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let opacity = arguments?["opacity"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonFillOpacity", details: nil))
                    return
                }
                displayRule?.polygonFillOpacity = opacity
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonFillOpacity", details: nil))
            }
        }
        
        func setPolygonStrokeColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonStrokeColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard var color = arguments?["color"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonStrokeColor", details: nil))
                    return
                }
                displayRule?.polygonStrokeColor = UIColor(fromHexString: color)
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonStrokeColor", details: nil))
            }
        }
        
        func setPolygonStrokeOpacity(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonStrokeOpacity", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let opacity = arguments?["opacity"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonStrokeOpacity", details: nil))
                    return
                }
                displayRule?.polygonStrokeOpacity = opacity
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonStrokeOpacity", details: nil))
            }
        }
        
        func setPolygonStrokeWidth(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonStrokeWidth", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let width = arguments?["width"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonStrokeWidth", details: nil))
                    return
                }
                displayRule?.polygonStrokeWidth = width
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonStrokeWidth", details: nil))
            }
        }
        
        func setPolygonVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonVisible", details: nil))
                    return
                }
                displayRule?.polygonVisible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonVisible", details: nil))
            }
        }
        
        func setPolygonZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomFrom = arguments?["zoomFrom"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonZoomFrom", details: nil))
                    return
                }
                displayRule?.polygonZoomFrom = zoomFrom
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonZoomFrom", details: nil))
            }
        }
        
        func setPolygonZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setPolygonZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomTo = arguments?["zoomTo"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setPolygonZoomTo", details: nil))
                    return
                }
                displayRule?.polygonZoomTo = zoomTo
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setPolygonZoomTo", details: nil))
            }
        }
        
        func getExtrusionColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getExtrusionColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(hexStringFromColor(color: displayRule!.extrusionColor!))
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getExtrusionColor", details: nil))
            }
        }
        
        func getExtrusionHeight(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getExtrusionHeight", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.extrusionHeight)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getExtrusionHeight", details: nil))
            }
        }
        
        func getExtrusionZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getExtrusionZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.extrusionZoomFrom)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getExtrusionZoomFrom", details: nil))
            }
        }
        
        func getExtrusionZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getExtrusionZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.extrusionZoomFrom)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getExtrusionZoomTo", details: nil))
            }
        }
        
        func getWallColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getWallColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(hexStringFromColor(color: displayRule!.wallsColor!))
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getWallColor", details: nil))
            }
        }
        
        func getWallHeight(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getWallHeight", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.wallsHeight)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getWallHeight", details: nil))
            }
        }
        
        func getWallZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getWallZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.wallsZoomFrom)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getWallZoomFrom", details: nil))
            }
        }
        
        func getWallZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_getWallZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.wallsZoomTo)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_getWallZoomTo", details: nil))
            }
        }
        
        func isExtrusionVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isExtrusionVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.extrusionVisible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isExtrusionVisible", details: nil))
            }
        }
        
        func isWallVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_isWallVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                result(displayRule!.wallsVisible)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_isWallVisible", details: nil))
            }
        }
        
        func setExtrusionColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setExtrusionColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard var color = arguments?["color"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setExtrusionColor", details: nil))
                    return
                }
                displayRule?.extrusionColor = UIColor(fromHexString: color)
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setExtrusionColor", details: nil))
            }
        }
        
        func setExtrusionHeight(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setExtrusionHeight", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let height = arguments?["height"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setExtrusionHeight", details: nil))
                    return
                }
                displayRule?.extrusionHeight = height
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setExtrusionHeight", details: nil))
            }
        }
        
        func setExtrusionVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setExtrusionVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setExtrusionVisible", details: nil))
                    return
                }
                displayRule?.extrusionVisible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setExtrusionVisible", details: nil))
            }
        }
        
        func setExtrusionZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setExtrusionZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomFrom = arguments?["zoomFrom"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setExtrusionZoomFrom", details: nil))
                    return
                }
                displayRule?.extrusionZoomFrom = zoomFrom
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setExtrusionZoomFrom", details: nil))
            }
        }
        
        func setExtrusionZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setExtrusionZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomTo = arguments?["zoomTo"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setExtrusionZoomTo", details: nil))
                    return
                }
                displayRule?.extrusionZoomTo = zoomTo
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setExtrusionZoomTo", details: nil))
            }
        }
        
        func setWallColor(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setWallColor", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard var color = arguments?["color"] as? String else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setWallColor", details: nil))
                    return
                }
                displayRule?.wallsColor = UIColor(fromHexString: color)
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setWallColor", details: nil))
            }
        }
        
        func setWallHeight(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setWallHeight", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let height = arguments?["height"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setWallHeight", details: nil))
                    return
                }
                displayRule?.wallsHeight = height
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setWallHeight", details: nil))
            }
        }
        
        func setWallVisible(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setWallVisible", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let visibility = arguments?["visible"] as? Bool else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setWallVisible", details: nil))
                    return
                }
                displayRule?.wallsVisible = visibility
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setWallVisible", details: nil))
            }
        }
        
        func setWallZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setWallZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomFrom = arguments?["zoomFrom"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setWallZoomFrom", details: nil))
                    return
                }
                displayRule?.wallsZoomFrom = zoomFrom
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setWallZoomFrom", details: nil))
            }
        }
        
        func setWallZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setWallZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomTo = arguments?["zoomTo"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setWallZoomTo", details: nil))
                    return
                }
                displayRule?.wallsZoomTo = zoomTo
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setWallZoomTo", details: nil))
            }
        }
        
        func setZoomFrom(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setZoomFrom", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomFrom = arguments?["zoomFrom"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setZoomFrom", details: nil))
                    return
                }
                displayRule?.zoomFrom = zoomFrom
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setZoomFrom", details: nil))
            }
        }
        
        func setZoomTo(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult) {
            guard let displayRuleId = arguments?["id"] as? String else {
                result(FlutterError(code: "Could not find id for DisplayRule", message: "DRU_setZoomTo", details: nil))
                return
            }
            
            let displayRule = getDisplayRule(id: displayRuleId)
            if (displayRule != nil) {
                guard let zoomTo = arguments?["zoomTo"] as? Double else {
                    result(FlutterError(code: "Could not find value for setter", message: "DRU_setZoomTo", details: nil))
                    return
                }
                displayRule?.zoomTo = zoomTo
                result(nil)
            }else {
                result(FlutterError(code: "No DisplayRule existing for this Id", message: "DRU_setZoomTo", details: nil))
            }
        }
    }
}

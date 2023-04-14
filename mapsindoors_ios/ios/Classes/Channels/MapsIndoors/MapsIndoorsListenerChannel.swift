//
//  MapsIndoorsListenerChannel.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 21/02/2023.
//

import Foundation
import Flutter
import UIKit
import MapsIndoors
import MapsIndoorsGoogleMaps
import GoogleMaps

public class MapsIndoorsListenerChannel: NSObject {
    enum Methods: String {
        case MIL_onMapsIndoorsReadyListener
        case MIL_onPositionUpdate
        
        func call(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel?) {
            if (methodChannel == nil) {
                return
            }
            
            let runner: (_ arguments: [String: Any]?, _ mapsIndoorsData: MapsIndoorsData, _ result: @escaping FlutterResult, _ methodChannel: FlutterMethodChannel) -> Void
            
            switch self {
            case .MIL_onMapsIndoorsReadyListener:             runner = onMapsIndoorsReadyListener
            case .MIL_onPositionUpdate:                       runner = onPositionUpdate
            }
            
            runner(arguments, mapsIndoorsData, result, methodChannel!)
        }
        
        func onMapsIndoorsReadyListener(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let setupListener = arguments?["addListener"] as? Bool else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MIL_onMapsIndoorsReadyListener", details: nil))
                return
            }
            if (setupListener) {
                mapsIndoorsData.delegate = ReadyDelegate(methodChannel: methodChannel)
            }else {
                mapsIndoorsData.delegate = nil
            }
        }
        
        func onPositionUpdate(arguments: [String: Any]?, mapsIndoorsData: MapsIndoorsData, result: @escaping FlutterResult, methodChannel: FlutterMethodChannel) {
            guard let position = arguments?["position"] as? String else {
                result(FlutterError(code: "Missing parameter to set listener", message: "MIL_onPositionUpdate", details: nil))
                return
            }
            
            let positionResult = try? JSONDecoder().decode(MPPositionResult.self, from: Data(position.utf8))
            if (positionResult != nil) {
                mapsIndoorsData.positionProvider?.setLatestPosition(positionResult: positionResult!)
            }
        }
    }
    
    class ReadyDelegate: MapsIndoorsReadyDelegate {
        let methodChannel: FlutterMethodChannel
        
        init(methodChannel: FlutterMethodChannel) {
            self.methodChannel = methodChannel
        }
        
        func isReady(error: MPError) {
            if (error == MPError.invalidApiKey || error == MPError.networkError || error == MPError.unknownError ) {
                methodChannel.invokeMethod("onMapsIndoorsReady", arguments: error)
            }else {
                methodChannel.invokeMethod("onMapsIndoorsReady", arguments: nil)
            }
        }
    }
}

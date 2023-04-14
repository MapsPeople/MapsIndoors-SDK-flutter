//
//  MapsIndoorsPlugin.swift
//  mapsindoors_ios
//
//  Created by Martin Hansen on 21/02/2023.

import Flutter
import Foundation
import UIKit
import MapsIndoors
import MapsIndoorsGoogleMaps
import GoogleMaps

public class MapsIndoorsPlugin: NSObject, FlutterPlugin {
    
    static let mapsIndoorsData: MapsIndoorsData = MapsIndoorsData()
    static var mapsIndoorsListenerChannel: FlutterMethodChannel? = nil
    static var mapControlListenerMethodChannel: FlutterMethodChannel? = nil
    static var directionsRendererListenerMethodChannel: FlutterMethodChannel? = nil
    static var mapControlFloorSelectorChannel: FlutterMethodChannel? = nil

    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = MapsIndoorsPlugin()

        directionsRendererListenerMethodChannel = FlutterMethodChannel(name: "DirectionsRendererMethodChannel", binaryMessenger: registrar.messenger())
        let directionsServiceMethodChannel = FlutterMethodChannel(name: "DirectionsServiceMethodChannel", binaryMessenger: registrar.messenger())
        let displayRuleMethodChannel = FlutterMethodChannel(name: "DisplayRuleMethodChannel", binaryMessenger: registrar.messenger())
        let mapControlMethodChannel = FlutterMethodChannel(name: "MapControlMethodChannel", binaryMessenger: registrar.messenger())
        let mapsIndoorsMethodChannel = FlutterMethodChannel(name: "MapsIndoorsMethodChannel", binaryMessenger: registrar.messenger())
        mapControlListenerMethodChannel = FlutterMethodChannel(name: "MapControlListenerMethodChannel", binaryMessenger: registrar.messenger())
        mapControlFloorSelectorChannel = FlutterMethodChannel(name: "MapControlFloorSelectorChannel", binaryMessenger: registrar.messenger())
        mapsIndoorsListenerChannel = FlutterMethodChannel(name: "MapsIndoorsListenerChannel", binaryMessenger: registrar.messenger())
        let utilMethodChannel = FlutterMethodChannel(name: "UtilMethodChannel", binaryMessenger: registrar.messenger())

        mapsIndoorsData.mapControlMethodChannel = mapControlMethodChannel
        mapsIndoorsData.mapsIndoorsMethodChannel = mapsIndoorsMethodChannel
        mapsIndoorsData.directionsRendererMethodChannel = directionsRendererListenerMethodChannel
        
        registrar.addMethodCallDelegate(instance, channel: directionsRendererListenerMethodChannel!)
        registrar.addMethodCallDelegate(instance, channel: directionsServiceMethodChannel)
        registrar.addMethodCallDelegate(instance, channel: displayRuleMethodChannel)
        registrar.addMethodCallDelegate(instance, channel: mapControlMethodChannel)
        registrar.addMethodCallDelegate(instance, channel: mapsIndoorsMethodChannel)
        registrar.addMethodCallDelegate(instance, channel: mapControlListenerMethodChannel!)
        registrar.addMethodCallDelegate(instance, channel: mapControlFloorSelectorChannel!)
        registrar.addMethodCallDelegate(instance, channel: mapsIndoorsListenerChannel!)
        
        registrar.addMethodCallDelegate(instance, channel: utilMethodChannel)
                    
        registrar.addApplicationDelegate(instance)
                
        let factory = FLNativeViewFactory(messenger: registrar.messenger(), mapsIndoorsData: mapsIndoorsData)
        registrar.register(factory, withId: "<map-view>")
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]
        if let method = DirectionsRendererMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result)
        }
        else if let method = MapControlMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result)
        }
        else if let method = DirectionsServiceMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result)
        }
        else if let method = DisplayRuleMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result)
        }
        //Map control channels
        else if let method = MapControlListenerMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result, methodChannel: MapsIndoorsPlugin.mapControlListenerMethodChannel)
        }
        else if let method = MapControlFloorSelectorChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result, methodChannel: MapsIndoorsPlugin.mapControlFloorSelectorChannel)
        }
        //Mapsindoors channels
        else if let method = MapsIndoorsMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result)
        }
        else if let method = MapsIndoorsListenerChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result, methodChannel: MapsIndoorsPlugin.mapsIndoorsListenerChannel)
        }
        else if let method = UtilMethodChannel.Methods(rawValue: call.method)
        {
            method.call(arguments: arguments, mapsIndoorsData: MapsIndoorsPlugin.mapsIndoorsData, result: result)
        }
        else
        {
            result(FlutterMethodNotImplemented)
        }
    }
}

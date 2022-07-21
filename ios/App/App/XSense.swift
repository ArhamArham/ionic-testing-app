import Foundation
import UIKit
import XsensDotSdk

@objc public class XSense: NSObject, XsensDotConnectionDelegate {
    
    
    var deviceList: [XsensDotDevice]?
    var connectList: [Any]?
    
    
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
    
    @objc func connectionManager(){
        XsensDotConnectionManager.setConnectionDelegate(self)
        XsensDotLog.setLogEnable(true)
        XsensDotReconnectManager.setEnable(true)
    }
    
    @objc func CoonectionviewWillDisappear(){
        XsensDotConnectionManager.stopScan()
    }
    
    
    @objc func scanDevices(){
        
        if !XsensDotConnectionManager.managerStateIsPoweredOn() {
            print("Please enable bluetoooth first")
            return
        }
        XsensDotConnectionManager.scan()
    }
    
    public func onScanCompleted() {
        print("Device ScanCompleted")
    }
    
    public func onDeviceConnectFailed(_ device: XsensDotDevice) {
        print("Device Connect Failed:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
    }
    
    public func onDeviceDisconnected(_ device: XsensDotDevice) {
        print("Device Disconnected:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
    }
    
    
    public func onDeviceConnectSucceeded(_ device: XsensDotDevice) {
        print("Device Connect Succeeded:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
    }
    
    public func onDiscover(_ device: XsensDotDevice) {
        print("Device Discover:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
    }
    
    
    
    
    
    
    
    
    
}

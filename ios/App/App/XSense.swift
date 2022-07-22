import Foundation
import UIKit
import XsensDotSdk

@objc public class XSense: NSObject, XsensDotConnectionDelegate {
    
    
    var deviceList = [XsensDotDevice]()
    var connectList = [XsensDotDevice]()
    var newDeviceList = [[String]]()
    let nc = NotificationCenter.default
    
    
  
    
    
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
        
        deviceList.removeAll()
        newDeviceList.removeAll()
        
           if connectList.count != 0 {
               
               deviceList += connectList
            }
        
        XsensDotConnectionManager.scan()
      
        
    }
    
    
    public func connectSpecifiDevice(udid:String) {
        
        let _ = deviceList.first { device in
            if device.macAddress == udid && !device.stateIsConnected(){
                
                
                    print("conncted")
                    connectList.append(device)
                    /// connect a sensor
                    XsensDotConnectionManager.connect(device)
                    /// add to DevicePool.
                    /// Reconnection has Two conditions,please also unbind it after disconnected .
                    /// 1. [XsensDotReconnectManager setEnable:YES];
                    /// 2. [XsensDotDevicePool bindDevice:device]
                    XsensDotDevicePool.bindDevice(device)
                    print("bind")
            
                
            }
            else {
                connectList.removeAll()
                /// Disconnect the sensor
                XsensDotConnectionManager.disconnect(device)
                /// Remove from the DevicePool
                XsensDotDevicePool.unbindDevice(device)
                print("unbind")
            }
            
            return true;
        }
        

        
    }
    
    public func onScanCompleted() {
        
        
        
        print("Device ScanCompleted\(deviceList.first)")
        
        
        
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil, userInfo: ["message":newDeviceList]);

    }
    
    func disconnectAll(){
        for item in connectList{
            print("item.displayName()-><-\(item.displayName())")
            XsensDotConnectionManager.disconnect(item)
            /// Remove from the DevicePool
            XsensDotDevicePool.unbindDevice(item)
        }
    }
    func DeviceStopScan(){
        print("Device Stop Scan ")
        XsensDotConnectionManager.stopScan()
    }
    
    public func onDeviceConnectFailed(_ device: XsensDotDevice) {
        print("Device Connect Failed:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
    }
    
    public func onDeviceDisconnected(_ device: XsensDotDevice) {
        print("Device Disconnected:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
        
        for (index,element) in newDeviceList.enumerated(){
            if let _ =  element.firstIndex(of: device.macAddress){
                newDeviceList[index] = [device.displayName(),device.macAddress,"\(device.stateIsConnected())"]
                break
            }
            
        }
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil, userInfo: ["message":newDeviceList]);
        
    }
    
    
    public func onDeviceConnectSucceeded(_ device: XsensDotDevice) {
        print("Device Connect Succeeded:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
       
        for (index,element) in newDeviceList.enumerated(){
            if let _ =  element.firstIndex(of: device.macAddress){
                newDeviceList[index] = [device.displayName(),device.macAddress,"\(device.stateIsConnected())"]
                break
            }
            
        }
        nc.post(name: Notification.Name("UserLoggedIn"), object: nil, userInfo: ["message":newDeviceList]);
        
    }
    
    public func onDiscover(_ device: XsensDotDevice) {
        print("Device Discover:\n Device macAddress:\(device.macAddress) -|- Device Name:\(device.displayName())")
            if !deviceList.contains(device) {
                deviceList.append(device)
                newDeviceList.append([device.displayName(),device.macAddress,"\(device.stateIsConnected())"])
            }
            
        
    }
    
    
    
    
    
    
    
    
    
}

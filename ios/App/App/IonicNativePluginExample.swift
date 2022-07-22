import Foundation
import Capacitor

@objc(IonicNativePluginExample)
public class IonicNativePluginExample: CAPPlugin {
    
    private let implementation = XSense()
    let nc = NotificationCenter.default
    
    @objc func DeviceList(notification: Notification){
        print("EVENT_LISTENER_NAME")
        self.notifyListeners("EVENT_LISTENER_NAMEQ", data: [
            "message":notification.userInfo!["message"]! as Any])
    }

    
    @objc func connectionManager(_ call: CAPPluginCall){
        nc.removeObserver(self, name: Notification.Name("UserLoggedIn"), object: nil)
        implementation.connectionManager()
        nc.addObserver(self, selector: #selector(DeviceList), name: Notification.Name("UserLoggedIn"), object: nil)
        call.resolve()
    }
    
    @objc func CoonectionviewWillDisappear(_ call: CAPPluginCall){
        implementation.CoonectionviewWillDisappear()
        call.resolve()
    }
    
    
    @objc func scanDevices(_ call: CAPPluginCall){
        
        implementation.scanDevices();
        call.resolve()
    }
    
    @objc func connectSpecifiDevice(_ call: CAPPluginCall){
        let value = call.getString("udid") ?? ""
        implementation.connectSpecifiDevice(udid: value)
        call.resolve()
    }
    
    @objc func disconnectAll(_ call: CAPPluginCall){
        implementation.disconnectAll()
        call.resolve()
    }

}

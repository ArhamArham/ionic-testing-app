import Foundation
import Capacitor

@objc(IonicNativePluginExample)
public class IonicNativePluginExample: CAPPlugin {
    private let implementation = XSense()

    @objc func NativeMethod(_ call: CAPPluginCall) {
        call.resolve(["message": "Hello iOS user!"])
    }

    @objc func NotifyListeners(_ call: CAPPluginCall) {
        self.notifyListeners(
            "EVENT_LISTENER_NAME",
            data: ["message": "Hello iOS user!"]
        )
    }
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
    
    @objc func connectionManager(_ call: CAPPluginCall){
        call.resolve()
    }
    
    @objc func CoonectionviewWillDisappear(_ call: CAPPluginCall){
        call.resolve()
    }
    
    
    @objc func scanDevices(_ call: CAPPluginCall){
        implementation.scanDevices();
        call.resolve()
    }

}

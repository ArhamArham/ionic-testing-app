#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>
#import <XsensDotSdk/XsensDotDevice.h>
#import <XsensDotSdk/XsensDotLog.h>
#import <XsensDotSdk/XsensDotDevicePool.h>
#import <XsensDotSdk/XsensDotConnectionManager.h>
#import <XsensDotSdk/XsensDotReconnectManager.h>


CAP_PLUGIN(IonicNativePluginExample, "IonicNativePluginExample",
           CAP_PLUGIN_METHOD(connectionManager, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(CoonectionviewWillDisappear, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(scanDevices, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(connectSpecifiDevice, CAPPluginReturnPromise);
           
)

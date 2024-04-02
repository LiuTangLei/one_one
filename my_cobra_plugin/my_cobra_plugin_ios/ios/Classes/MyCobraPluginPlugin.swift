import Flutter
import UIKit
import Cobra

public class MyCobraPluginPlugin: NSObject, FlutterPlugin {
  var cobra: Cobra?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_cobra_plugin_ios", binaryMessenger: registrar.messenger())
    let instance = MyCobraPluginPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initializeCobra":
        do {
            let args = call.arguments as! [String: Any]
            let accessKey = args["accessKey"] as! String
            self.cobra = try Cobra(accessKey: accessKey)
            result(nil)
        } catch {
            result(FlutterError(code: "COBRA_INIT_FAILED", message: "Cobra initialization failed", details: nil))
        }
    case "processAudioFrame":
        guard let cobra = self.cobra else {
            result(FlutterError(code: "COBRA_NOT_INITIALIZED", message: "Cobra is not initialized", details: nil))
            return
        }
        let args = call.arguments as! [String: Any]
        let frame = args["frame"] as! [Int16]
        do {
            let voiceProbability = try cobra.process(pcm: frame)
            result(voiceProbability)
        } catch {
            result(FlutterError(code: "COBRA_PROCESS_FAILED", message: "Cobra processing failed", details: nil))
        }
    case "dispose":
        self.cobra?.delete()
        result(nil)
    case "getPlatformName":
        result("iOS")
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}
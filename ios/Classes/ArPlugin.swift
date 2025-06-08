import Flutter
import UIKit
import ARKit
import RealityKit
public class ArPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ar_plugin", binaryMessenger: registrar.messenger())
    let instance = ArPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            switch call.method {
            case "getPlatformVersion":
                result("iOS " + UIDevice.current.systemVersion)
            case "showArScreen":
                guard let args = call.arguments as? [String: Any],
                      let modelName = args["modelName"] as? String,
                      let scale = args["scale"] as? Double else {
                    result(FlutterError(code: "INVALID_ARGUMENTS", message: "modelName and scale are required.", details: nil))
                    return
                }

                guard let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
                    result(FlutterError(code: "NO_ROOT_VIEW_CONTROLLER", message: "Could not find root view controller.", details: nil))
                    return
                }

                let arViewController = ARViewController(modelName: modelName, scale: scale)
                arViewController.modalPresentationStyle = .fullScreen
                rootViewController.present(arViewController, animated: true, completion: nil)

                result(nil) // Indicate success to Flutter
            default:
                result(FlutterMethodNotImplemented)
            }
        }
}

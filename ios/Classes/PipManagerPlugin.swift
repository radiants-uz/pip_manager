import Flutter
import UIKit
import AVKit

public class PipManagerPlugin: NSObject, FlutterPlugin {
  var playerLayer: AVPlayerLayer?
  var player: AVPlayer?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "pip_manager", binaryMessenger: registrar.messenger())
    let instance = PipManagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "startPiP" {
      guard let args = call.arguments as? [String: Any],
            let videoUrl = args["url"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "URL is required", details: nil))
        return
      }
      enterPictureInPicture(withUrl: videoUrl)
      result(nil)
    } else if call.method == "exitPiP" {
      exitPictureInPicture()       
      result(nil)
    } else {           
      result(FlutterMethodNotImplemented)
    }
  }

  private func enterPictureInPicture(withUrl urlString: String) {
    guard let url = URL(string: urlString) else { return }

    player = AVPlayer(url: url)
    playerLayer = AVPlayerLayer(player: player)
    guard let window = UIApplication.shared.keyWindow else { return }

    playerLayer?.frame = CGRect(x: 0, y: 0, width: 200, height: 200) // PiP size
    playerLayer?.backgroundColor = UIColor.black.cgColor
    window.layer.addSublayer(playerLayer!)

    player?.play()
  }

  private func exitPictureInPicture() {
    playerLayer?.removeFromSuperlayer()
    playerLayer = nil
    player?.pause()
    player = nil
  }
}

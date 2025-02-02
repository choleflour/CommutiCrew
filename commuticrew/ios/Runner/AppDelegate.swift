import Flutter
import UIKit
import GoogleMaps 
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    

    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyC0PWvwGYzaNtbQF7Q72pkkkyd_YEZDuvg")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // 키가 없으면 앱은 Google Maps 대신 직접 그린 지도를 씁니다(ApiConfig.mapsEnabled).
    if let key = Self.dartDefine("GOOGLE_MAPS_API_KEY"), !key.isEmpty {
      GMSServices.provideAPIKey(key)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }

  /// `--dart-define`(`--dart-define-from-file=env.json`) 값 하나.
  /// Flutter 가 빌드 설정 DART_DEFINES 에 `base64(KEY=VALUE)` 를 쉼표로 이어 두고,
  /// Info.plist 의 `DartDefines` 가 그 값을 앱에 싣습니다.
  private static func dartDefine(_ name: String) -> String? {
    guard let raw = Bundle.main.object(forInfoDictionaryKey: "DartDefines") as? String else {
      return nil
    }
    for encoded in raw.split(separator: ",") {
      guard let data = Data(base64Encoded: String(encoded)),
        let pair = String(data: data, encoding: .utf8),
        let eq = pair.firstIndex(of: "=")
      else { continue }
      if pair[..<eq] == name {
        return String(pair[pair.index(after: eq)...])
      }
    }
    return nil
  }
}

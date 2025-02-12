// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDYAlchF1u4QHPm7HsOJg4kcHS96ZelAio',
    appId: '1:580545643050:web:28d1f7f8bb6792077f7953',
    messagingSenderId: '580545643050',
    projectId: 'communiticrew',
    authDomain: 'communiticrew.firebaseapp.com',
    storageBucket: 'communiticrew.firebasestorage.app',
    measurementId: 'G-HSB160SRPS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS9Xz_kHexEqyqLfe6eJ8LpJJHQR5CUak',
    appId: '1:580545643050:android:806dc7a3b67a6bd77f7953',
    messagingSenderId: '580545643050',
    projectId: 'communiticrew',
    storageBucket: 'communiticrew.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJWbHtHK-mj4E035RVxPSB7nED1o_YE2g',
    appId: '1:580545643050:ios:a285fe81b63ff3e07f7953',
    messagingSenderId: '580545643050',
    projectId: 'communiticrew',
    storageBucket: 'communiticrew.firebasestorage.app',
    iosBundleId: 'com.example.commuticrew',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBJWbHtHK-mj4E035RVxPSB7nED1o_YE2g',
    appId: '1:580545643050:ios:a285fe81b63ff3e07f7953',
    messagingSenderId: '580545643050',
    projectId: 'communiticrew',
    storageBucket: 'communiticrew.firebasestorage.app',
    iosBundleId: 'com.example.commuticrew',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDYAlchF1u4QHPm7HsOJg4kcHS96ZelAio',
    appId: '1:580545643050:web:01d7867bd1b5611b7f7953',
    messagingSenderId: '580545643050',
    projectId: 'communiticrew',
    authDomain: 'communiticrew.firebaseapp.com',
    storageBucket: 'communiticrew.firebasestorage.app',
    measurementId: 'G-V6PYBGDBRP',
  );
}

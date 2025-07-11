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
    apiKey: 'AIzaSyBBbice8xh6DC8Z9x4bxris39xPm1fJ4jo',
    appId: '1:322455493408:web:58d66a3ca3827643e6d545',
    messagingSenderId: '322455493408',
    projectId: 'app-akademie-test-app',
    authDomain: 'app-akademie-test-app.firebaseapp.com',
    storageBucket: 'app-akademie-test-app.firebasestorage.app',
    measurementId: 'G-576KTCQPYD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBm5ZOEjbqtnfWDyNFifEAZ5jK3C7H3lss',
    appId: '1:322455493408:android:a3656f32ac55a8aae6d545',
    messagingSenderId: '322455493408',
    projectId: 'app-akademie-test-app',
    storageBucket: 'app-akademie-test-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJT_tNPMtsPStblKtii5YZk9GbAmJxWJQ',
    appId: '1:322455493408:ios:f7379ffd52681028e6d545',
    messagingSenderId: '322455493408',
    projectId: 'app-akademie-test-app',
    storageBucket: 'app-akademie-test-app.firebasestorage.app',
    iosBundleId: 'com.example.firebaseTestApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJT_tNPMtsPStblKtii5YZk9GbAmJxWJQ',
    appId: '1:322455493408:ios:f7379ffd52681028e6d545',
    messagingSenderId: '322455493408',
    projectId: 'app-akademie-test-app',
    storageBucket: 'app-akademie-test-app.firebasestorage.app',
    iosBundleId: 'com.example.firebaseTestApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBBbice8xh6DC8Z9x4bxris39xPm1fJ4jo',
    appId: '1:322455493408:web:13fe8a2a876ba277e6d545',
    messagingSenderId: '322455493408',
    projectId: 'app-akademie-test-app',
    authDomain: 'app-akademie-test-app.firebaseapp.com',
    storageBucket: 'app-akademie-test-app.firebasestorage.app',
    measurementId: 'G-GPH47NRYRC',
  );
}

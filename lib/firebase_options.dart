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
    apiKey: 'AIzaSyAR74wWnbrCsIfBXc1w3a_Rzn375qh3Iww',
    appId: '1:234195727900:web:0e8454563c5cd3bb2251d9',
    messagingSenderId: '234195727900',
    projectId: 'ipet-ededd',
    authDomain: 'ipet-ededd.firebaseapp.com',
    storageBucket: 'ipet-ededd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsn3H9vk7VAMQlfej4DTEn_ywx6S9Z8Xc',
    appId: '1:234195727900:android:7c1e42ef92f6541e2251d9',
    messagingSenderId: '234195727900',
    projectId: 'ipet-ededd',
    storageBucket: 'ipet-ededd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXKbbC3d5q-hwhng0tTryvb6LLx4f-zQo',
    appId: '1:234195727900:ios:0cbb9d3b63c891612251d9',
    messagingSenderId: '234195727900',
    projectId: 'ipet-ededd',
    storageBucket: 'ipet-ededd.appspot.com',
    iosBundleId: 'com.example.ipetuseradmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXKbbC3d5q-hwhng0tTryvb6LLx4f-zQo',
    appId: '1:234195727900:ios:0cbb9d3b63c891612251d9',
    messagingSenderId: '234195727900',
    projectId: 'ipet-ededd',
    storageBucket: 'ipet-ededd.appspot.com',
    iosBundleId: 'com.example.ipetuseradmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDSUfRxS3OX4ijWScRGchsmpVVtkdLHu0U',
    appId: '1:234195727900:web:e3d4cdad69dcd7e92251d9',
    messagingSenderId: '234195727900',
    projectId: 'ipet-ededd',
    authDomain: 'ipet-ededd.firebaseapp.com',
    storageBucket: 'ipet-ededd.appspot.com',
  );
}

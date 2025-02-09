// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB6FenOQQDxxjCX0PXVP-b3Aqry8by1Jos',
    appId: '1:306433095750:web:bee03205b4fbed99d23247',
    messagingSenderId: '306433095750',
    projectId: 'friendsflow-cf4cb',
    authDomain: 'friendsflow-cf4cb.firebaseapp.com',
    storageBucket: 'friendsflow-cf4cb.appspot.com',
    measurementId: 'G-TDW6D9M1T2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHURikDw3qd3-_IimdX5XHDRS2BsSsvVA',
    appId: '1:306433095750:android:2f1895bed27ee879d23247',
    messagingSenderId: '306433095750',
    projectId: 'friendsflow-cf4cb',
    storageBucket: 'friendsflow-cf4cb.appspot.com',
  );
}

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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyD2XlMNIf-20RCK43c9sv3ZEsZMtMr6DBo',
    appId: '1:771843172316:web:6fd5ccc167479265881119',
    messagingSenderId: '771843172316',
    projectId: 'probusproject-2ea6c',
    authDomain: 'probusproject-2ea6c.firebaseapp.com',
    storageBucket: 'probusproject-2ea6c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBt1AjB9Ypn5JuFa54zZUFv4peehdYeek0',
    appId: '1:771843172316:android:824fd116087bb41c881119',
    messagingSenderId: '771843172316',
    projectId: 'probusproject-2ea6c',
    storageBucket: 'probusproject-2ea6c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIuEThx2jLB81VxALnWyWQgQu_QLzBwBE',
    appId: '1:771843172316:ios:42a8a28b148501f6881119',
    messagingSenderId: '771843172316',
    projectId: 'probusproject-2ea6c',
    storageBucket: 'probusproject-2ea6c.appspot.com',
    iosClientId: '771843172316-b5jbb8nb5eu7b34cfgdrj2ktsh0er5td.apps.googleusercontent.com',
    iosBundleId: 'com.example.proBusApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIuEThx2jLB81VxALnWyWQgQu_QLzBwBE',
    appId: '1:771843172316:ios:42a8a28b148501f6881119',
    messagingSenderId: '771843172316',
    projectId: 'probusproject-2ea6c',
    storageBucket: 'probusproject-2ea6c.appspot.com',
    iosClientId: '771843172316-b5jbb8nb5eu7b34cfgdrj2ktsh0er5td.apps.googleusercontent.com',
    iosBundleId: 'com.example.proBusApp',
  );
}
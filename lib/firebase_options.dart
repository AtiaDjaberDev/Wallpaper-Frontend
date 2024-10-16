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
    apiKey: 'AIzaSyBqdirGrlwWtlEOi4TPIALuGOwQQneSdj0',
    appId: '1:879254810412:web:47e2cdeecf83b89b548689',
    messagingSenderId: '879254810412',
    projectId: 'photo-share-b314f',
    authDomain: 'photo-share-b314f.firebaseapp.com',
    storageBucket: 'photo-share-b314f.appspot.com',
    measurementId: 'G-48YBM46Y1X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANpDBLk5_29FKZeq36TuWp3B6G9R0avPY',
    appId: '1:879254810412:android:914dc02cbf45f668548689',
    messagingSenderId: '879254810412',
    projectId: 'photo-share-b314f',
    storageBucket: 'photo-share-b314f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyChk-SXp3aePDeWCk8-shuyZIBOeAG-0GA',
    appId: '1:879254810412:ios:b71b79033a2edf4c548689',
    messagingSenderId: '879254810412',
    projectId: 'photo-share-b314f',
    storageBucket: 'photo-share-b314f.appspot.com',
    iosBundleId: 'com.example.funSound',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyChk-SXp3aePDeWCk8-shuyZIBOeAG-0GA',
    appId: '1:879254810412:ios:b71b79033a2edf4c548689',
    messagingSenderId: '879254810412',
    projectId: 'photo-share-b314f',
    storageBucket: 'photo-share-b314f.appspot.com',
    iosBundleId: 'com.example.funSound',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBqdirGrlwWtlEOi4TPIALuGOwQQneSdj0',
    appId: '1:879254810412:web:9bea74f123f6dc9c548689',
    messagingSenderId: '879254810412',
    projectId: 'photo-share-b314f',
    authDomain: 'photo-share-b314f.firebaseapp.com',
    storageBucket: 'photo-share-b314f.appspot.com',
    measurementId: 'G-GCF1C3DDJS',
  );

}
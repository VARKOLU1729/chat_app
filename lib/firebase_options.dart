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
    apiKey: 'AIzaSyCqj5o5hjEJYvWGuhWhGq7XVxFPd9ZBVHI',
    appId: '1:610511051514:web:6a38bcc53293b708c70743',
    messagingSenderId: '610511051514',
    projectId: 'music-ca52d',
    authDomain: 'music-ca52d.firebaseapp.com',
    storageBucket: 'music-ca52d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDH3IOblpggTl_9H4Tf9CthzIs5ptF-eug',
    appId: '1:610511051514:android:210c5d15cf78cb41c70743',
    messagingSenderId: '610511051514',
    projectId: 'music-ca52d',
    storageBucket: 'music-ca52d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCM2K9qgNn0g5bFL5TEFgaGVhBIdE-Dh80',
    appId: '1:610511051514:ios:512f749bbee3b230c70743',
    messagingSenderId: '610511051514',
    projectId: 'music-ca52d',
    storageBucket: 'music-ca52d.appspot.com',
    iosBundleId: 'com.example.runoMusic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCM2K9qgNn0g5bFL5TEFgaGVhBIdE-Dh80',
    appId: '1:610511051514:ios:512f749bbee3b230c70743',
    messagingSenderId: '610511051514',
    projectId: 'music-ca52d',
    storageBucket: 'music-ca52d.appspot.com',
    iosBundleId: 'com.example.runoMusic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCqj5o5hjEJYvWGuhWhGq7XVxFPd9ZBVHI',
    appId: '1:610511051514:web:2a39a95c5ca165ebc70743',
    messagingSenderId: '610511051514',
    projectId: 'music-ca52d',
    authDomain: 'music-ca52d.firebaseapp.com',
    storageBucket: 'music-ca52d.appspot.com',
  );
}

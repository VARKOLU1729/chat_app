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
    apiKey: 'AIzaSyCLU_CK_cfPj6T6na4OjdfviiWpJTIM2Jc',
    appId: '1:177140422860:web:45136f19cab94f5c75ca69',
    messagingSenderId: '177140422860',
    projectId: 'chat-2932e',
    authDomain: 'chat-2932e.firebaseapp.com',
    storageBucket: 'chat-2932e.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPYz3QYBPT7DRvevDcBryes2lN9-hQaYs',
    appId: '1:177140422860:android:fe54accad148783875ca69',
    messagingSenderId: '177140422860',
    projectId: 'chat-2932e',
    storageBucket: 'chat-2932e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlZ3ApEn7ocO_Vkz8r5ECumr2LSf1Vv7E',
    appId: '1:177140422860:ios:f5b72de1d54adc4075ca69',
    messagingSenderId: '177140422860',
    projectId: 'chat-2932e',
    storageBucket: 'chat-2932e.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlZ3ApEn7ocO_Vkz8r5ECumr2LSf1Vv7E',
    appId: '1:177140422860:ios:f5b72de1d54adc4075ca69',
    messagingSenderId: '177140422860',
    projectId: 'chat-2932e',
    storageBucket: 'chat-2932e.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCLU_CK_cfPj6T6na4OjdfviiWpJTIM2Jc',
    appId: '1:177140422860:web:a67a24f2bd1710e475ca69',
    messagingSenderId: '177140422860',
    projectId: 'chat-2932e',
    authDomain: 'chat-2932e.firebaseapp.com',
    storageBucket: 'chat-2932e.firebasestorage.app',
  );

}
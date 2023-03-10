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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2Hbk7tEviDazyGMKXmWKMHVBfAagdvZo',
    appId: '1:909234130361:android:b5912f7bd68bab1d69ba68',
    messagingSenderId: '909234130361',
    projectId: 'chat-app-f848e',
    storageBucket: 'chat-app-f848e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXLoBUxG4vPDWSaXIwG7HpjPqm0bzGSjc',
    appId: '1:909234130361:ios:2fbc2652fcd128a769ba68',
    messagingSenderId: '909234130361',
    projectId: 'chat-app-f848e',
    storageBucket: 'chat-app-f848e.appspot.com',
    androidClientId: '909234130361-sssjc4boqq41qstfrjnet1dhlhksv1jb.apps.googleusercontent.com',
    iosClientId: '909234130361-2u2ka32f7olsr4e6jrh31031ghi4vgip.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}

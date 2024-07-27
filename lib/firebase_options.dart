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
    apiKey: 'AIzaSyBBUxZG4ow7-H6yRJbsSjfBap5y4B-k3wQ',
    appId: '1:509392311492:web:7de8bd5c57d2abecdca591',
    messagingSenderId: '509392311492',
    projectId: 'provider-todo-app-f655b',
    authDomain: 'provider-todo-app-f655b.firebaseapp.com',
    storageBucket: 'provider-todo-app-f655b.appspot.com',
    measurementId: 'G-S8DVPWQY4W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxemelNwby_BOfnVkyp-GRKvljyryWcjA',
    appId: '1:509392311492:android:9a180f930df79bfbdca591',
    messagingSenderId: '509392311492',
    projectId: 'provider-todo-app-f655b',
    storageBucket: 'provider-todo-app-f655b.appspot.com',
  );
}

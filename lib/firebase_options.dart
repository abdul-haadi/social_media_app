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
    apiKey: 'AIzaSyAjdVkupZRvmDBNHOgM_M2ARUTFp_VJ9ug',
    appId: '1:389219410540:web:9cfe9ce35a5b7c59d7ae49',
    messagingSenderId: '389219410540',
    projectId: 'social-media-f6fb3',
    authDomain: 'social-media-f6fb3.firebaseapp.com',
    storageBucket: 'social-media-f6fb3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbxlb06ESiwvZf_T50uUb1tlHXeqT50tc',
    appId: '1:389219410540:android:9aed5b226f3b8850d7ae49',
    messagingSenderId: '389219410540',
    projectId: 'social-media-f6fb3',
    storageBucket: 'social-media-f6fb3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBegFhwYmzBE5pfdf7g258hl8LVBA172BY',
    appId: '1:389219410540:ios:cd0f2c3315f87258d7ae49',
    messagingSenderId: '389219410540',
    projectId: 'social-media-f6fb3',
    storageBucket: 'social-media-f6fb3.appspot.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBegFhwYmzBE5pfdf7g258hl8LVBA172BY',
    appId: '1:389219410540:ios:cd0f2c3315f87258d7ae49',
    messagingSenderId: '389219410540',
    projectId: 'social-media-f6fb3',
    storageBucket: 'social-media-f6fb3.appspot.com',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjdVkupZRvmDBNHOgM_M2ARUTFp_VJ9ug',
    appId: '1:389219410540:web:a06f948f98bac6e9d7ae49',
    messagingSenderId: '389219410540',
    projectId: 'social-media-f6fb3',
    authDomain: 'social-media-f6fb3.firebaseapp.com',
    storageBucket: 'social-media-f6fb3.appspot.com',
  );
}

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
    apiKey: 'AIzaSyB1o756FSkxXpr9k74T-29YdVQk2FxvwbE',
    appId: '1:420623738874:android:e5b83169e86ec1a047e643',
    messagingSenderId: '420623738874',
    projectId: 'ethtransactionstfg',
    databaseURL: 'https://ethtransactionstfg-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ethtransactionstfg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9H6cd3TIpoxoZAyoiwZzYIw_yxRYmg24',
    appId: '1:420623738874:ios:862068b641b0882447e643',
    messagingSenderId: '420623738874',
    projectId: 'ethtransactionstfg',
    databaseURL: 'https://ethtransactionstfg-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'ethtransactionstfg.appspot.com',
    iosClientId: '420623738874-gvqdfq49oh9jdsootau6jbd9a12234pd.apps.googleusercontent.com',
    iosBundleId: 'com.example.ethTransactions',
  );
}

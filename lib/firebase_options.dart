// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnwM0xl6s5_GRNwXX7j-4w6_OLHK9KPVE',
    appId: '1:329079699835:android:1576aeed27a8a151a925de',
    messagingSenderId: '329079699835',
    projectId: 'raro-estacionamento',
    storageBucket: 'raro-estacionamento.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKh4Bvn-LsoVxwuGky4IWSLzzFUOtONIM',
    appId: '1:329079699835:ios:ad45ebc4b7ea3feda925de',
    messagingSenderId: '329079699835',
    projectId: 'raro-estacionamento',
    storageBucket: 'raro-estacionamento.appspot.com',
    iosClientId: '329079699835-hbd4a7p5fi80gg0coe8it1iua54rg0v2.apps.googleusercontent.com',
    iosBundleId: 'com.example.raroEstacionamento',
  );
}

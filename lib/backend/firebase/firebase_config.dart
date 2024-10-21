import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC-V5O6sABzH7H-brpdFLQX3Omr9LAUdxI",
            authDomain: "areyoufreecsc305.firebaseapp.com",
            projectId: "areyoufreecsc305",
            storageBucket: "areyoufreecsc305.appspot.com",
            messagingSenderId: "307576316949",
            appId: "1:307576316949:web:9f0c911f8dea06c69ada1c",
            measurementId: "G-1FZ82XB53K"));
  } else {
    await Firebase.initializeApp();
  }
}

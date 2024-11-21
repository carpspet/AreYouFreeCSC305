import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAWgVLlgAOPfQ5LsHX-eRKTbRTgx1QB3Vw",
            authDomain: "are-you-free-c-s-c305-00m51j.firebaseapp.com",
            projectId: "are-you-free-c-s-c305-00m51j",
            storageBucket: "are-you-free-c-s-c305-00m51j.appspot.com",
            messagingSenderId: "1047363104597",
            appId: "1:1047363104597:web:cff9c2eb83a8f1201e49dc",
            measurementId: "G-P007V8Y50G"));
  } else {
    await Firebase.initializeApp();
  }
}

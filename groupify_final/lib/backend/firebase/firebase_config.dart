import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA50p_gfZPzhs6x1EYXZAZ-Nri-FFIcb4s",
            authDomain: "groupify-final-x8mazy.firebaseapp.com",
            projectId: "groupify-final-x8mazy",
            storageBucket: "groupify-final-x8mazy.appspot.com",
            messagingSenderId: "738766374478",
            appId: "1:738766374478:web:ab4c4c7a2b994c9487a51f"));
  } else {
    await Firebase.initializeApp();
  }
}

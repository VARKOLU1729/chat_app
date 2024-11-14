import 'package:chat_app/Screens/chat_contacts_screen.dart';
import 'package:chat_app/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/Screens/chat_screen.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  return runApp(
      MaterialApp(
        home: ChatContactsScreen(),
        // home: StreamBuilder(
        //     stream: FirebaseAuth.instance.authStateChanges(),
        //     builder: (context, snapshot)
        //     {
        //       if(snapshot.hasData) return ChatContactsScreen();
        //       return LoginScreen();
        //     }
        // ),
    )
  );
}

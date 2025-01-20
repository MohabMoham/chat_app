import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat_app/firebase_options.dart';
import 'package:scholar_chat_app/pages/chat_page.dart';
import 'package:scholar_chat_app/pages/login_page.dart';
import 'package:scholar_chat_app/pages/register_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( const Scholar_Chat());
}

class Scholar_Chat extends StatelessWidget
{
  const Scholar_Chat({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     routes: {
       'login page': (context) => LoginPage(),
       'register page': (context) => RegisterPage(),
       'chat page':(context) => ChatPage(),
     },
     home: LoginPage()
   );
  }

}



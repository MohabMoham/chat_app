
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../widgets/custom_login_button.dart';
import '../widgets/custom_text_field.dart';
class RegisterPage extends StatefulWidget {
   RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
String? email;

String? password;

GlobalKey<FormState> formKey = GlobalKey();

bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xff2B475E),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,


              children: [
                Spacer(),
                Image.asset('assets/images/scholar.png'),
                Text(
                  'Scholar Chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    onChanged: (data) {
                      email = data;
                    },
                    hintText: 'Email'
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obscureText: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hintText: 'Password'
                ),

                SizedBox(
                  height: 20,
                ),
                CustomLoginButton(
                    buttonText: 'Register',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {

                        });
                        try {
                          await registerUser();
                          showSnackBar(context, 'success');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'weak password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context, 'emai already exist');
                          }
                        } catch (e) {
                          print(e);
                        }
                        isLoading = false;
                        setState(() {

                        });
                      }
                    }


                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Row(

                    children: [
                      Text(
                        'already have an account?  ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      )
                    ],

                  ),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }



  Future<void> registerUser() async {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!, password: password!,);
  }
}

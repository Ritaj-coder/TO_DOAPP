import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/home/auth/customer_formfield.dart';
import 'package:to_do_app1/home/auth/register/register_screen.dart';
import 'package:to_do_app1/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = "Login";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  // const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        title: Text("WELCOME BACK",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.WhiteColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: formkey,
                child: Column(
                  children: [
                    CustomerForm(
                      label: "EMAIL",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "PLEASE ENTER EMAIL";
                        }
                        final bool emailvalid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailcontroller.text);
                        if (!emailvalid) {
                          return "PLEASE ENTER VALID EMAIL";
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      keyboardtype: TextInputType.emailAddress,
                    ),
                    CustomerForm(
                      label: "PASSWORD",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "PLEASE ENTER PASSWORD";
                        }
                        if (text.length < 6) {
                          return "PASSWORD MUST BE AT LEAST 6";
                        }
                        return null;
                      },
                      controller: passcontroller,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Text(
                            "LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.WhiteColor),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routename);
                          },
                          child: Text(
                            "OR Create An Account",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.PrimaryColor),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, HomeScreen.routename);
                          },
                          child: Text(
                            "Skip",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.PrimaryColor),
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void login() async {
    if (formkey.currentState?.validate() == true) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailcontroller.text, password: passcontroller.text);
        print("Login Succeded");
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

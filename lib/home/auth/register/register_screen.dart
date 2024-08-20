import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/home/auth/customer_formfield.dart';

class RegisterScreen extends StatelessWidget {
  static const String routename = "Register";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();

  // const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        title: Text("Create Account",
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
                      label: "USERNAME",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "PLEASE ENTER USERNAME";
                        }
                        return null;
                      },
                      controller: namecontroller,
                    ),
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
                    CustomerForm(
                      label: "CONFIRMPASSWORD",
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "PLEASE CONFIRM PASSWORD";
                        }
                        if (text.length < 6) {
                          return "PASSWORD MUST BE AT LEAST 6";
                        }
                        if (text != passcontroller.text) {
                          return "CONFIRM PASSWORD MUST MATCH PASSWORD!";
                        }
                        return null;
                      },
                      controller: confirmpasscontroller,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            "CREATE ACCOUNT",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.WhiteColor),
                          )),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void register() async {
    if (formkey.currentState?.validate() == true) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passcontroller.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}

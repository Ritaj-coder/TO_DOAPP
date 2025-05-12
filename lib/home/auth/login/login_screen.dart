import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/firebase.dart';
import 'package:to_do_app1/home/auth/customer_formfield.dart';
import 'package:to_do_app1/home/auth/register/register_screen.dart';
import 'package:to_do_app1/home/home_screen.dart';
import 'package:to_do_app1/providers/user_provider.dart';

import '../../../alert_dialog.dart';

class LoginScreen extends StatelessWidget {
  static const String routename = "Login";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<UserProvider>(context);
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
        child: SizedBox(
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
                              login(context);
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
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      DialogAlerts.showLoading(context: context, loadinglabel: "Waiting...");
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text,
          password: passcontroller.text,
        );
        var user =
            await FireBase.readuserfromFireStore(credential.user?.uid ?? "");
        if (user == null) return;

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateuser(user);

        DialogAlerts.hideLoading(context);
        DialogAlerts.showMessage(
          context: context,
          content: "Login Successful",
          title: "Success",
          posActionName: "Ok",
          posAction: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogAlerts.hideLoading(context);
        DialogAlerts.showMessage(
          context: context,
          content: "Invalid credentials, please try again.",
          title: "Error",
          posActionName: "Ok",
        );
      } catch (e) {
        DialogAlerts.hideLoading(context);
        DialogAlerts.showMessage(
          context: context,
          content: e.toString(),
          title: "Error",
          posActionName: "Ok",
        );
      }
    }
  }
}

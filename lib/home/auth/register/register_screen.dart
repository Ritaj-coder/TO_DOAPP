import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/alert_dialog.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/firebase.dart';
import 'package:to_do_app1/home/auth/customer_formfield.dart';
import 'package:to_do_app1/home/auth/login/login_screen.dart';
import 'package:to_do_app1/home/home_screen.dart';
import 'package:to_do_app1/model/my_user.dart';

import '../../../providers/user_provider.dart';

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
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        title: Text("Create Account",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.WhiteColor, fontSize: 24)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
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
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 28),
                              backgroundColor: AppColors.PrimaryColor),
                          onPressed: () {
                            register(context);
                          },
                          child: Text(
                            "CREATE ACCOUNT",
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
                            Navigator.pushNamed(context, LoginScreen.routename);
                          },
                          child: Text(
                            "OR Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.PrimaryColor),
                          )),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future<void> register(BuildContext context) async {
    //todo: show loading
    if (formkey.currentState!.validate() == true) {
      DialogAlerts.showLoading(context: context, loadinglabel: "Loading...");
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passcontroller.text,
        );

        MyUser myUser = MyUser(
            ID: credential.user?.uid ?? '',
            Name: namecontroller.text,
            Email: emailcontroller.text);
        await FireBase.addusertoFireStore(myUser);

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateuser(myUser);

        //todo: hide loading
        DialogAlerts.hideLoading(context);
        //todo: show message
        DialogAlerts.showMessage(
            context: context,
            content: "Register Successed",
            title: "Success",
            posActionName: "Ok",
            posAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            });
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo: hide loading
          DialogAlerts.hideLoading(context);
          //todo: show message
          DialogAlerts.showMessage(
              context: context,
              content: "The password provided is too weak",
              title: "Error",
              posActionName: "Ok");
        } else if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogAlerts.hideLoading(context);
          //todo: show message
          DialogAlerts.showMessage(
              context: context,
              content: "The account already exists for that email.",
              title: "Error",
              posActionName: "Ok");
        }
      } catch (e) {
        //todo: hide loading
        DialogAlerts.hideLoading(context);
        //todo: show message
        DialogAlerts.showMessage(
            context: context,
            content: e.toString(),
            title: "Error",
            posActionName: "Ok");
      }
    }
  }
}

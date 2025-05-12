import 'package:flutter/material.dart';
import 'package:to_do_app1/app_Colors.dart';

class DialogAlerts {
  static void showLoading(
      {required BuildContext context, required String loadinglabel}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 9,
                ),
                Text(
                  loadinglabel,
                  style: TextStyle(color: AppColors.BlackColor),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String content,
      String title = 'Title',
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.PrimaryColor),
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName)));
    }

    if (negActionName != null) {
      actions.add(ElevatedButton(
          style:
              ElevatedButton.styleFrom(backgroundColor: AppColors.GreenyColor),
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text(
                content,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.BlackColor),
              ),
              title: Text(title),
              actions: actions);
        });
  }
}

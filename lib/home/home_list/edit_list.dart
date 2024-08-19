import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app1/app_Colors.dart';

class EditList extends StatelessWidget {
  static const String routename = "Edit";

  const EditList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter, // or any other alignment
          child: Container(
            padding: EdgeInsets.all(15),
            height: MediaQuery.of(context).size.height * 0.63,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: AppColors.WhiteColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Text(
                  "Edit Task",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "This is Title",
                            labelStyle: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Task Details",
                            labelStyle: Theme.of(context).textTheme.bodyMedium),
                        maxLines: 6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_date),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "13/8/2024",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save Changes",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ))
                  ],
                ))
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/firebase.dart';

import '../../model/task.dart';
import '../../providers/list_proivder.dart';

class EditList extends StatefulWidget {
  static const String routename = "Edit";
  Task task;

  EditList({required this.task});

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  var selectDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";

  @override
  Widget build(BuildContext context) {
    var listproivder = Provider.of<ListProvider>(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.15,
          title: Text(
            AppLocalizations.of(context)!.app_title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        body: SingleChildScrollView(
          child: Align(
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
                              labelStyle:
                                  Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Task Details",
                              labelStyle:
                                  Theme.of(context).textTheme.bodyMedium),
                          maxLines: 6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(AppLocalizations.of(context)!.select_date),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            showcalender();
                          },
                          child: Text(
                            "${selectDate.day}/${selectDate.month}/"
                            "${selectDate.year}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            FireBase.updateTask(widget.task)
                                .timeout(Duration(seconds: 1), onTimeout: () {
                              print("Task Edited");
                              listproivder.getAllTasksFromFireStore();
                              Navigator.pop(context);
                            });
                          },
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
          ),
        ));
  }

  void showcalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectDate = chosenDate;
      setState(() {});
    }

    ///ANOTHER WAY INSTEAD OF IF
    //  selectDate = chosenDate ?? selectDate ;
  }
}

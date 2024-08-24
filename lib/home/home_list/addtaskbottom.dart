import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/firebase.dart';
import 'package:to_do_app1/model/task.dart';

import '../../providers/list_proivder.dart';

class AddTaskBottom extends StatefulWidget {
  @override
  State<AddTaskBottom> createState() => _AddTaskBottomState();
}

class _AddTaskBottomState extends State<AddTaskBottom> {
  String title = "";
  String description = "";
  var selectDate = DateTime.now();
  late ListProvider plistprovider;
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    plistprovider = Provider.of<ListProvider>(context);
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.add_task),
            Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "PLease Enter Task Title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Enter Task Title",
                            labelStyle: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "PLease Enter Task Description";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Enter Task Description",
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
                          addtask();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.add,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Icon(
                              Icons.check,
                              size: 35,
                            )
                          ],
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void addtask() {
    if (formkey.currentState!.validate() == true) {
      Task task =
          Task(Title: title, Description: description, dateTime: selectDate);
      FireBase.addtasktoFireStore(task).timeout(Duration(seconds: 1),
          onTimeout: () {
        print("task added");
        plistprovider.getAllTasksFromFireStore();
        Navigator.pop(context);
      });
    }
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

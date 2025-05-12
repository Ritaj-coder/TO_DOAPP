import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/firebase.dart';
import 'package:to_do_app1/model/task.dart';
import 'package:to_do_app1/providers/list_proivder.dart';
import 'package:to_do_app1/providers/user_provider.dart';

class EditList extends StatefulWidget {
  static const String routename = "Edit";
  Task task;

  EditList({required this.task});

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  var selectDate = DateTime.now();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.Title);
    descriptionController =
        TextEditingController(text: widget.task.Description);
    selectDate = widget.task.dateTime;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

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
          alignment: Alignment.topCenter,
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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: titleController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Please enter a title";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "This is Title",
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: descriptionController,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Please enter a description";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Task Details",
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                          ),
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
                          onTap: showcalender,
                          child: Text(
                            "${selectDate.day}/${selectDate.month}/${selectDate.year}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            widget.task.Title = titleController.text;
                            widget.task.Description =
                                descriptionController.text;
                            widget.task.dateTime = selectDate;

                            FireBase.updateTask(
                                    widget.task, userProvider.currentuser!.ID)
                                .then((_) {
                              print("Task Edited");
                              listProvider.getAllTasksFromFireStore(
                                  userProvider.currentuser!.ID);
                              Navigator.pop(context);
                            }).catchError((error) {
                              print("Error updating task: $error");
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save Changes",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showcalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (chosenDate != null) {
      setState(() {
        selectDate = chosenDate;
      });
    }
  }
}

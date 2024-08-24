import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app1/app_Colors.dart';
import 'package:to_do_app1/firebase.dart';
import 'package:to_do_app1/home/home_list/edit_list.dart';

import '../../model/task.dart';
import '../../providers/list_proivder.dart';

class TaskList extends StatefulWidget {
  // const TaskList({super.key});
  Task task;
  static const String routename = "tasklist";

  TaskList({required this.task});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool isTaskDone = false;
  @override
  Widget build(BuildContext context) {
    var listproivder = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                FireBase.deletetaskfromFireStore(widget.task)
                    .timeout(Duration(seconds: 1), onTimeout: () {
                  print("TASK DELETED");
                  listproivder.getAllTasksFromFireStore();
                });
              },
              backgroundColor: AppColors.RedColor,
              foregroundColor: AppColors.WhiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => EditList(
                              task: widget.task,
                            )));
              },
              backgroundColor: AppColors.PrimaryColor,
              foregroundColor: AppColors.WhiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.WhiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * 0.1,
                width: 6,
                color: widget.task.isdone
                    ? AppColors.GreenyColor
                    : AppColors.PrimaryColor,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.task.Title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!.copyWith(
                        color: widget.task.isdone
                            ? AppColors.GreenyColor
                            : AppColors.PrimaryColor),
                  ),
                  Text(widget.task.Description,
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              )),
              widget.task.isdone
                  ? Text("Done!",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.GreenyColor))
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.PrimaryColor),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.task.isdone = true;
                            FireBase.updateIsDone(widget.task);
                          });
                        },
                        icon: Icon(
                          Icons.check,
                          size: 45,
                          color: AppColors.WhiteColor,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

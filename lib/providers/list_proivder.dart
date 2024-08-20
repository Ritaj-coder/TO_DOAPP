import 'package:flutter/material.dart';

import '../firebase.dart';
import '../model/task.dart';

class ListProvider extends ChangeNotifier {
  List<Task> taskslist = [];
  var selectdate = DateTime.now();

  void getAllTasksFromFireStore() async {
    var querySnapshot = await FireBase.getTaskCollection().get();

    taskslist = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    /// filter tasks according to date

    taskslist = taskslist.where((task) {
      if (selectdate.day == task.dateTime.day &&
          selectdate.month == task.dateTime.month &&
          selectdate.year == task.dateTime.year) {
        return true;
      }
      return false;
    }).toList();

    /// sort tasks

    taskslist.sort((task1, task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newdate) {
    selectdate = newdate;
    getAllTasksFromFireStore();
  }
}

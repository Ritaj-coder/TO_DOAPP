import 'package:to_do_app1/model/createcollection.dart';

import 'model/task.dart';

class FireBase {
  static Future<void> addtasktoFireStore(Task task) {
    var taskCollection = CreateCollection.getTaskCollection();

    ///collection
    var taskdoc = taskCollection.doc();

    ///document
    task.ID = taskdoc.id;
    return taskdoc.set(task);
  }
}

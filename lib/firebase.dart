import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/task.dart';

class FireBase {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addtasktoFireStore(Task task) {
    var taskCollection = getTaskCollection();

    ///collection
    var taskdoc = taskCollection.doc();

    ///document
    task.ID = taskdoc.id;
    return taskdoc.set(task);
  }

  static Future<void> deletetaskfromFireStore(Task task) {
    return getTaskCollection().doc(task.ID).delete();
  }

  static Future<void> updateIsDone(Task task) async {
    return await getTaskCollection()
        .doc(task.ID)
        .update({'isDone': task.isdone});
  }

  static Future<void> updateTask(Task task) async {
    try {
      await getTaskCollection().doc(task.ID).update({
        'title': task.Title,
        'description': task.Description,
        'time': task.dateTime,
        'isDone': task.isdone,
      });
    } catch (e) {
      print("Error updating task: $e");
    }
  }
}

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

  static Future<void> deletetaskfromFireStore(Task task) async {
    getTaskCollection().doc(task.ID).delete();
  }
}

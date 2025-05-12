import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app1/model/my_user.dart';

import 'model/task.dart';

class FireBase {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addtasktoFireStore(Task task, String uid) {
    var taskCollection = getTaskCollection(uid);

    ///collection
    var taskdoc = taskCollection.doc();

    ///document
    task.ID = taskdoc.id;
    return taskdoc.set(task);
  }

  static Future<void> deletetaskfromFireStore(Task task, String uid) {
    return getTaskCollection(uid).doc(task.ID).delete();
  }

  static Future<void> updateIsDone(Task task, String uid) async {
    return await getTaskCollection(uid)
        .doc(task.ID)
        .update({'isDone': task.isdone});
  }

  static Future<void> updateTask(Task task, String uid) async {
    try {
      await getTaskCollection(uid).doc(task.ID).update({
        'title': task.Title,
        'description': task.Description,
        'time': Timestamp.fromDate(task.dateTime),
        'isDone': task.isdone,
      });
    } catch (e) {
      print("Error updating task: $e");
    }
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!)),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addusertoFireStore(MyUser user) {
    return getUserCollection().doc(user.ID).set(user);
  }

  static Future<MyUser?> readuserfromFireStore(String uid) async {
    var snapshot = await getUserCollection().doc(uid).get();
    return snapshot.data();
  }
}

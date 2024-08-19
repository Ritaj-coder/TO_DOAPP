import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app1/model/task.dart';

class CreateCollection {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }
}

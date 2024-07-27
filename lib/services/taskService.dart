import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/models/addTaskModel.dart';

class TaskService {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('Tasks');

  Future<TaskModel?> createTask(TaskModel task) async {
    try {
      final taskMap = task.toMap();
      await _taskCollection.doc(task.id).set(taskMap);
      return task;
    } on FirebaseException catch (e) {
      print(e);
    }
  }

//get all tasks
  Stream<List<TaskModel>> getAllTasks() {
    try {
      return _taskCollection.snapshots().map((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot data) {
          return TaskModel.fromJson(data.data() as Map<String, dynamic>);
        }).toList();
      });
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  //get current user task only
  // Future<TaskModel> getMytasks(TaskModel task)async{
  //   try{
  //     return _taskCollection.doc()
  //   }on FirebaseException catch(e){}
  // }
}

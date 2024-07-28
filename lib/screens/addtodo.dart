import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/models/addTaskModel.dart';
import 'package:provider/services/taskService.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  final TaskModel? task;
  const AddTodo({super.key, this.task});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;
  bool _edit = false;

  getdata() {
    if (widget.task != null) {
      setState(() {
        _titleController.text = widget.task!.title!;
        _descriptionController.text = widget.task!.description!;
        _edit = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _edit == true
            ? Text(
                'Update Task',
                style: GoogleFonts.aBeeZee(),
              )
            : Text(
                'Add Task',
                style: GoogleFonts.aBeeZee(),
              ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _edit == true
                          ? Text(
                              'Update Task',
                              style: GoogleFonts.aBeeZee(fontSize: 25),
                            )
                          : Text(
                              'Add Task',
                              style: GoogleFonts.aBeeZee(fontSize: 25),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Title';
                          }
                        },
                        style: GoogleFonts.aBeeZee(),
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Description';
                          }
                        },
                        controller: _descriptionController,
                        style: GoogleFonts.aBeeZee(),
                        decoration: InputDecoration(hintText: 'Description'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (_edit == true) {
                              TaskModel task = TaskModel();
                              TaskService taskService = TaskService();
                              task = TaskModel(
                                  id: widget.task?.id,
                                  title: _titleController.text,
                                  description: _descriptionController.text);
                              taskService.updateTask(task);
                              Navigator.pop(context);
                            } else {
                              _addTask();
                            }
                          }
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * .05,
                          child: Center(
                              child: _edit == true
                                  ? Text(
                                      'Update',
                                      style: GoogleFonts.aBeeZee(fontSize: 20),
                                    )
                                  : Text(
                                      'Create',
                                      style: GoogleFonts.aBeeZee(fontSize: 20),
                                    )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(255, 166, 219, 168),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                    visible: _isloading,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 150, 193, 152),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addTask() async {
    setState(() {
      _isloading = true;
    });
    var id = Uuid().v1();
    TaskModel _taskmodel = TaskModel(
        id: id,
        title: _titleController.text,
        description: _descriptionController.text,
        userid: FirebaseAuth.instance.currentUser!.uid,
        createdAt: DateTime.now(),
        status: true);
    TaskService _tasksevice = TaskService();
    final task = await _tasksevice.createTask(_taskmodel);
    if (task != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Task Added')));
      Navigator.pop(context);
      setState(() {
        _isloading = false;
      });
    } else {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to Add Task')));
    }
  }
}

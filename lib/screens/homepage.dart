import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/models/addTaskModel.dart';
import 'package:provider/screens/addtodo.dart';
import 'package:provider/services/taskService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TaskService _taskService1 = TaskService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo View',
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Todo List',
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Expanded(
              child: StreamBuilder<List<TaskModel>>(
                  stream: TaskService().getAllTasks(),
                  builder: (context, snapshot) {
                    List<TaskModel> tasks = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final _tasks = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              tileColor: Color.fromARGB(255, 210, 248, 211),
                              title: Text(
                                '${_tasks.title}',
                                // '${_tasks.title}',
                                style: GoogleFonts.aBeeZee(),
                              ),
                              subtitle: Text(
                                '${_tasks.description}',
                                // '${_tasks.description}',
                                style: GoogleFonts.aBeeZee(),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {}, icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.delete)),
                                ],
                              )),
                        );
                      },
                      itemCount: tasks.length,
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addtodo');
        },
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 33, 40, 33),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/models/addTaskModel.dart';
import 'package:provider/screens/addtodo.dart';
import 'package:provider/services/taskService.dart';
import 'package:provider/services/userService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo View',
          style: GoogleFonts.aBeeZee(fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _userService.logout();
                Navigator.pushNamed(context, '/login');
              },
              icon: Icon(
                Icons.logout,
              ))
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Todo List',
              style: GoogleFonts.aBeeZee(fontSize: 20),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Expanded(
              child: StreamBuilder<List<TaskModel>>(
                  stream: TaskService().getAllTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<TaskModel> tasks = snapshot.data!;
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final tasks0 = tasks[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                tileColor:
                                    const Color.fromARGB(255, 210, 248, 211),
                                title: Text(
                                  '${tasks0.title}',
                                  // '${_tasks.title}',
                                  style: GoogleFonts.aBeeZee(),
                                ),
                                subtitle: Text(
                                  '${tasks0.description}',
                                  // '${_tasks.description}',
                                  style: GoogleFonts.aBeeZee(),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => AddTodo(
                                              task: tasks0,
                                            ),
                                          ));
                                        },
                                        icon: const Icon(Icons.edit)),
                                    IconButton(
                                        onPressed: () {
                                          TaskService taskService =
                                              TaskService();
                                          taskService.deleteTask(tasks0.id);
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                )),
                          );
                        },
                        itemCount: tasks.length,
                      );
                    }
                    return Center(
                      child: Text(
                        'No data Found',
                        style: GoogleFonts.aBeeZee(),
                      ),
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
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 33, 40, 33),
        ),
      ),
    );
  }
}

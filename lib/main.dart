import 'package:flutter/material.dart';
import 'package:to_do_list/bloc/task_block.dart';

import 'model/task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final taskBloc = TaskBloc();

  @override
  void dispose() {
    taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas Stream"),
      ),
      body: StreamBuilder<List<Task>>(
        stream: taskBloc.tasksStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Nenhuma tarefa encontrada"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Task task = snapshot.data![index];
              return ListTile(
                title: Text(task.description),
                leading: Checkbox(
                  value: task.completed,
                  onChanged: (value) {
                    taskBloc.toggleTaskStatus(task.id);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    taskBloc.removeTask(task.id);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicione uma nova tarefa
          taskBloc.addTask(Task(id: taskBloc.tasks.length + 1, description: "Nova Tarefa"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TaskListScreen(),
  ));
}
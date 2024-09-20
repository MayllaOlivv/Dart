import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

// StatelessWidget que encapsula o app
class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

// StatefulWidget para gerenciar a lista de tarefas
class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> tasks = []; // Lista de tarefas
  TextEditingController taskController = TextEditingController();

  // Método para adicionar uma nova tarefa
  void addTask(String taskTitle) {
    setState(() {
      tasks.add(Task(taskTitle: taskTitle));
    });
    taskController.clear(); // Limpa o campo de texto após adicionar
  }

  // Método para alternar o estado do checkbox
  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto para adicionar novas tarefas
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  labelText: 'Nova Tarefa',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // Botão para adicionar tarefa
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  addTask(taskController.text);
                }
              },
              child: Text('Adicionar Tarefa'),
            ),
            // Lista de tarefas
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                    toggleCompletion: () => toggleTaskCompletion(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe que representa uma tarefa
class Task {
  String taskTitle;
  bool isCompleted;

  Task({required this.taskTitle, this.isCompleted = false});
}

// StatelessWidget que exibe cada item de tarefa
class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback toggleCompletion;

  TaskItem({required this.task, required this.toggleCompletion});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          task.taskTitle,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) {
            toggleCompletion();
          },
        ),
      ),
    );
  }
}

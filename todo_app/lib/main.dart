import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoリスト',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoListPage(),
    );
  }
}

class Todo {
  String title;
  String description;
  bool isDone;
  Todo({required this.title, required this.description, this.isDone = false});
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Todo> _todos = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _addTodo() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    if (title.isEmpty) return;
    setState(() {
      _todos.add(Todo(title: title, description: desc));
      _titleController.clear();
      _descController.clear();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoリスト'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'タイトル',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: '説明',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addTodo,
                child: const Text('追加'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _todos.isEmpty
                  ? const Center(child: Text('ToDoがありません'))
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (val) {
                                setState(() {
                                  todo.isDone = val ?? false;
                                });
                              },
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(todo.description),
                          ),
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

import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController todoController = TextEditingController();

  List<Map<String, dynamic>> todoList = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: todoController,
              decoration: InputDecoration(
                hintText: "Tulis Kegiatan...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: tambahTodo,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Expanded(
              child: todoList.isEmpty
                  ? const Center(child: Text("Belum ada Todo List"))
                  : ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {

                        final todo = todoList[index];


                        return Card(
                          child: ListTile(

                            leading: Checkbox(
                              value: todo["isDone"],
                              onChanged: (value) {
                                setState(() {
                                  todo["isDone"] = value!;
                                });
                              },
                            ),

                            title: Text(
                              todo["title"],
                              style: TextStyle(
                                decoration: todo["isDone"]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),

                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => editTodoDialog(index),
                                ),
                               

                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => hapusTodo(index),
                                ),
                              ],
                            ),
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

  void tambahTodo(){
    if (todoController.text.trim().isEmpty) return;

    setState(() {
      todoList.add({
        "title": todoController.text,
        "isDone": false,
      });
      todoController.clear();
    });
  }

  void hapusTodo(int index){
    setState(() {
      todoList.removeAt(index);
    });
  }

  void editTodoDialog(int index){
    todoController.text = todoList[index]["title"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Todo"),
          content: TextField(
            controller: todoController,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todoList[index]["title"] = todoController.text;
                });
                todoController.clear();
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
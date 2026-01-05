import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController todoController = TextEditingController();
  List<String> todoList = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List'), 
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white, 
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: todoController,
            decoration: InputDecoration(hintText: "Tulis Kegiatan...",
            suffixIcon: IconButton(icon: const Icon(Icons.add),
            onPressed: tambahTodo,
            )
            ),
          ),
          const SizedBox(height: 16,),

          Expanded(child: todoList.isEmpty ? const Center(child: Text("Belum ada Todo List")):
          ListView.builder(itemCount: todoList.length, itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text(todoList[index]),
                trailing: IconButton(icon : const Icon(Icons.delete, color: Colors.red),
                onPressed: () => hapusTodo(index),
                
                ),
              ),
            );
          }
          
          )
          )


        ],),
      ),
    );
  }
  void tambahTodo(){
    if (todoController.text.trim().isEmpty)
    return;

    setState(() {
      todoList.add(todoController.text);
      todoController.clear();
    });
  }

  void hapusTodo(int index){
    setState(() {
      todoList.removeAt(index);
    });
  }

}
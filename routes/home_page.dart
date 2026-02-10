import 'package:flutter/material.dart';
import '/routes.dart';
import '/model/todo_model.dart';
import '/widgets/footer_name.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<Todo> list1=const [
    Todo("Dart", "This is Dart"),
    Todo("Flutter", "This is Flutter"),
    Todo("Java", "This is Java"),
    Todo("C#", "This is C#"),
  ];

  const HomePage({super.key}); // ✅ proper constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Page")),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: list1.length,
          itemBuilder: (context, index) {
            final item= list1[index];
            return Card(
              child: ListTile(
                title: Text(item.Title, style: TextStyle(color: Colors.blueGrey, fontSize: 20, fontWeight: FontWeight.bold),),
                trailing: ElevatedButton(onPressed: () {
                  context.read<TodoProvider>().selectTodo(item);
                  Navigator.pushNamed(context, RouteGenerator.randomPage);
                  },
                  child: const Text("View")
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
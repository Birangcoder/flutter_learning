import 'package:first/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/model/todo_model.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  double _fontSize = 20;

  @override
  void initState() {
    super.initState();
    // Trigger the style animation AFTER build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _fontSize = 40; // 👈 Animate from 20 → 40
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = context.watch<TodoProvider>().selectedTodo;

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Random Page")),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 1500),
              curve: Curves.elasticOut,
              style: TextStyle(
                fontSize: _fontSize,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
              child: Text(item?.Desc ?? "No Todo selected"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenerator.iconAnimPage);
              },
              child: const Text("iconAnim Page"),
            ),
          ],
        ),
      ),
    );
  }
}

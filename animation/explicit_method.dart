import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimationDemo(),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  State<AnimationDemo> createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnim;
  late Animation<double> rotateAnim;
  late Animation<Color?> colorAnim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    scaleAnim = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    rotateAnim = Tween<double>(begin: 0, end: 1).animate(controller);

    // ✅ Color Animation (CORRECT WAY)
    colorAnim = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explicit Animation Demo")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: rotateAnim.value * 2 * 3.14,
                child: Transform.scale(
                  scale: scaleAnim.value,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: colorAnim.value, // ✅ animated color
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => controller.forward(),
                child: const Text("Forward"),
              ),
              ElevatedButton(
                onPressed: () => controller.reverse(),
                child: const Text("Reverse"),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => controller.repeat(reverse: true),
                child: const Text("Repeat"),
              ),
              ElevatedButton(
                onPressed: () => controller.stop(),
                child: const Text("Stop"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

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
      home: ExpAnimation(),
    );
  }
}

class ExpAnimation extends StatefulWidget {
  const ExpAnimation({super.key});

  @override
  State<ExpAnimation> createState() => _ExpAnimationState();
}

class _ExpAnimationState extends State<ExpAnimation>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> scaleAnim;
  late Animation<double> rotateAnim;
  late Animation<double> fadeAnim;
  late Animation<Offset> slideAnim;

  @override
  void initState() {
    super.initState();

    // 1️⃣ AnimationController
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // 2️⃣ Scale Animation (Tween + Curve)
    scaleAnim = Tween<double>(begin: 0.5, end: 1.2).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    // 3️⃣ Rotation Animation
    rotateAnim = Tween<double>(begin: 0, end: 1).animate(controller);

    // 4️⃣ Fade Animation
    fadeAnim = Tween<double>(begin: 0, end: 1).animate(controller);

    // 5️⃣ Slide Animation
    slideAnim = Tween<Offset>(
      begin: const Offset(1, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explicit Animations")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SCALE
            const Text("1. Scale Animation"),
            AnimatedBuilder(
              animation: scaleAnim,
              builder: (context, child) {
                return Transform.scale(
                  scale: scaleAnim.value,
                  child: child,
                );
              },
              child: box(Colors.blue),
            ),
            const SizedBox(height: 20),

            // ROTATION
            const Text("2. Rotation Animation"),
            AnimatedBuilder(
              animation: rotateAnim,
              builder: (context, child) {
                return Transform.rotate(
                  angle: rotateAnim.value * 3.14 * 2,
                  child: child,
                );
              },
              child: box(Colors.red),
            ),
            const SizedBox(height: 20),

            // FADE
            const Text("3. Fade Animation"),
            AnimatedBuilder(
              animation: fadeAnim,
              builder: (context, child) {
                return Opacity(
                  opacity: fadeAnim.value,
                  child: child,
                );
              },
              child: box(Colors.green),
            ),
            const SizedBox(height: 20),

            // SLIDE
            const Text("4. Slide Animation"),
            SlideTransition(
              position: slideAnim,
              child: box(Colors.orange),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.status == AnimationStatus.completed) {
                    controller.reverse();
                  } else {
                    controller.forward();
                  }
                },
                child: const Text("Animate"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget box(Color color) {
    return Container(
      width: 80,
      height: 80,
      color: color,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

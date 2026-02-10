import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Example extends HookWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final controller1 = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    final controller2 = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: controller1,
              child: const FlutterLogo(size: 80),
            ),

            ScaleTransition(
              scale: controller2,
              child: const Icon(Icons.favorite, size: 80, color: Colors.red),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => controller1.forward(from: 0),
              child: const Text("Fade Logo"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => controller2.forward(from: 0),
              child: const Text("Scale Heart"),
            ),
          ],
        ),
      ),
    );
  }
}

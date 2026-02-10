import 'dart:math' as math;
import 'package:flutter/material.dart';

/// This widget just rotates the logo using the controller passed to it.
class RotatingLogo extends AnimatedWidget {
  static const _fullRotation = 2 * math.pi;

  const RotatingLogo({
    super.key,
    required AnimationController controller,
  }) : super(listenable: controller);

  AnimationController get _controller => listenable as AnimationController;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _controller.value * _fullRotation,
      child: const FlutterLogo(size: 120),
    );
  }
}

/// ✅ This is the page that will be pushed by Navigator.
/// It creates the AnimationController and runs the animation.
class IconAnimPage extends StatefulWidget {
  const IconAnimPage({super.key});

  @override
  State<IconAnimPage> createState() => _IconAnimPageState();
}

class _IconAnimPageState extends State<IconAnimPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // 👈 keeps rotating forever
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rotating Icon")),
      body: Center(
        child: RotatingLogo(controller: _controller),
      ),
    );
  }
}

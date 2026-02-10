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
      home: ImpAnimation(),
    );
  }
}

class ImpAnimation extends StatefulWidget {
  const ImpAnimation({super.key});

  @override
  State<ImpAnimation> createState() => _ImpAnimationState();
}

class _ImpAnimationState extends State<ImpAnimation> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Implicit Animations")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 1️⃣ AnimatedContainer
              const Text("1. AnimatedContainer (size, color)"),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: toggle ? 200 : 100,
                height: 50,
                color: toggle ? Colors.blue : Colors.red,
              ),
              const SizedBox(height: 20),

              // 2️⃣ AnimatedOpacity
              const Text("2. AnimatedOpacity (fade in / out)"),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: toggle ? 1.0 : 0.2,
                child: const Text(
                  "Hello Flutter",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // 3️⃣ AnimatedAlign
              const Text("3. AnimatedAlign (move position)"),
              Container(
                height: 60,
                color: Colors.grey.shade300,
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 400),
                  alignment:
                  toggle ? Alignment.centerRight : Alignment.centerLeft,
                  child: const Icon(Icons.circle, size: 30),
                ),
              ),
              const SizedBox(height: 20),

              // 4️⃣ AnimatedPadding
              const Text("4. AnimatedPadding (padding change)"),
              AnimatedPadding(
                duration: const Duration(milliseconds: 400),
                padding: EdgeInsets.all(toggle ? 20 : 5),
                child: Container(
                  height: 40,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),

              // 5️⃣ AnimatedPositioned
              const Text("5. AnimatedPositioned (free movement)"),
              SizedBox(
                height: 80,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 400),
                      left: toggle ? 150 : 10,
                      top: 20,
                      child: const Icon(Icons.star, size: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 6️⃣ AnimatedCrossFade
              const Text("6. AnimatedCrossFade (switch between two widgets)"),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 400),
                firstChild: const Icon(Icons.play_arrow, size: 40),
                secondChild: const Icon(Icons.pause, size: 40),
                crossFadeState: toggle
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
              ),
              const SizedBox(height: 20),

              // 7️⃣ AnimatedSwitcher
              const Text("7. AnimatedSwitcher (widget replacement)"),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: toggle
                    ? const Icon(Icons.check, size: 40, key: ValueKey(1))
                    : const Icon(Icons.close, size: 40, key: ValueKey(2)),
              ),
              const SizedBox(height: 30),

              // Toggle Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      toggle = !toggle;
                    });
                  },
                  child: const Text("Animate"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

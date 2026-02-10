import 'package:flutter/material.dart';

class StepperControlExample extends StatefulWidget {
  const StepperControlExample({super.key});

  @override
  State<StepperControlExample> createState() => _StepperControlExampleState();
}

class _StepperControlExampleState extends State<StepperControlExample> {
  int _currentStep = 0;
  final TextEditingController _nameController = TextEditingController();
  bool _isStepOneValid = false;

  void _continue() {
    if (_currentStep == 0) {
      // Validate step 0
      if (_nameController.text.isNotEmpty) {
        setState(() {
          _isStepOneValid = true;
          _currentStep = 1;
        });
      } else {
        setState(() {
          _isStepOneValid = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please enter your name")));
      }
    } else if (_currentStep < 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("you have done ${_nameController.text}")),
      );
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Controlled Stepper")),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: _continue,
        onStepCancel: _cancel,

        // 👇 CUSTOM ICONS HERE
        stepIconBuilder: (stepIndex, stepState) {
          if (stepIndex == 0) {
            return const Icon(Icons.person, color: Colors.white);
          } else if (stepIndex == 1) {
            return const Icon(Icons.check_circle, color: Colors.white);
          }
          return const Icon(Icons.circle);
        },

        steps: [
          Step(
            title: const Text("Enter Name"),
            content: TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            state: _isStepOneValid ? StepState.complete : StepState.editing,
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text("Confirm"),
            content: const Text("Everything looks good!"),
            isActive: _currentStep >= 1,
          ),
        ],
      ),
    );
  }
}

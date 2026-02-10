import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: LayoutBuilder(
        builder: (context, dimensions) {
          final width = dimensions.maxWidth / 1.5;
          final height = dimensions.maxHeight / 3;

          return Center(
            child: SizedBox(
              width: width,
              height: height,
              child: SingleChildScrollView(child: const LoginFormWidget()),
            ),
          );
        },
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return "At least 8 characters required";
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      // All validations passed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.mail),
              hintText: "Email",
            ),
            validator: _validateEmail,
          ),

          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.vpn_key),
              hintText: "Password",
            ),
            obscureText: true,
            validator: _validatePassword,
          ),

          ElevatedButton(
            onPressed: _login,
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}

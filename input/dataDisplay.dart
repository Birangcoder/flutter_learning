import 'package:flutter/material.dart';

class dataDisplay extends StatelessWidget{
  final String name,email,course,gender;
  final int phone,age;
  final DateTime dob;

  const dataDisplay({super.key, required this.name, required this.email, required this.course, required this.gender, required this.phone, required this.age, required this.dob});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Display data"),),
      body: Center(
        child: Column(
          children: [
            Text(name),
            Text(email),
            Text(phone.toString()),
            Text(age.toString()),
            Text(course),
            Text(gender),
            Text(dob.toString()),
          ],
        ),
      ),
    );
  }
}
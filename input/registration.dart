import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dataDisplay.dart';

class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});

  @override
  State<StudentRegistrationForm> createState() =>
      _StudentRegistrationFormState();
}

class _StudentRegistrationFormState extends State<StudentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();

  String? course;
  String gender = "Male";
  DateTime? dob;
  bool agree = false;
  File? profileImage;

  /// Image Picker
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        profileImage = File(picked.path);
      });
    }
  }

  /// Date Picker
  Future<void> pickDate() async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        dob = selected;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameFocus.requestFocus(); // focus when YOU want
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Student Registration"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Profile Image
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? const Icon(Icons.camera_alt, size: 30)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Name
              TextFormField(
                controller: nameController,
                focusNode: nameFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(emailFocus);
                },
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter name" : null,
              ),
              const SizedBox(height: 16),

              /// Email
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.contains("@") ? null : "Enter valid email",
              ),
              const SizedBox(height: 16),

              /// Phone
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // ⛔ blocks characters
                ],
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "Enter valid 10 digit phone number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                // autofocus: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "OTP",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
              ),
              const SizedBox(height: 16),

              /// Age
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter age" : null,
              ),
              const SizedBox(height: 16),

              /// Course Dropdown
              DropdownButtonFormField<String>(
                initialValue: course,
                decoration: const InputDecoration(
                  labelText: "Course",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "BCA", child: Text("BCA")),
                  DropdownMenuItem(value: "BSc", child: Text("BSc")),
                  DropdownMenuItem(value: "BCom", child: Text("BCom")),
                  DropdownMenuItem(value: "BA", child: Text("BA")),
                ],
                onChanged: (value) {
                  setState(() {
                    course = value;
                  });
                },
                validator: (value) => value == null ? "Select course" : null,
              ),
              const SizedBox(height: 16),

              /// Gender (Radio)
              const Text("Gender"),
              Row(
                children: [
                  Radio(
                    value: "Male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text("Male"),
                  Radio(
                    value: "Female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const Text("Female"),
                ],
              ),

              /// Date of Birth
              ListTile(
                title: Text(
                  dob == null
                      ? "Select Date of Birth"
                      : "DOB: ${dob!.day}/${dob!.month}/${dob!.year}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: pickDate,
              ),

              /// Terms Checkbox
              CheckboxListTile(
                value: agree,
                title: const Text("I agree to terms & conditions"),
                onChanged: (value) {
                  setState(() {
                    agree = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    if (!agree) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please accept terms")),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Student Registered Successfully 🎉"),
                      ),
                    );

                    /// Here you can send data to API / Firebase / Database
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => dataDisplay(
                          name: nameController.text,
                          email: emailController.text,
                          course: course!,
                          gender: gender,
                          phone: int.parse(phoneController.text),
                          age: int.parse(ageController.text),
                          dob: dob!,
                        ),
                      ),
                    );
                  },
                  child: const Text("Register", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

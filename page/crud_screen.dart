import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String? selectedDocId; // for update

  // CREATE
  Future<void> addUser() async {
    await firestore.collection("users").add({
      "name": nameController.text,
      "city": cityController.text,
      "createdAt": DateTime.now(),
    });

    nameController.clear();
    cityController.clear();
  }

  // UPDATE
  Future<void> updateUser() async {
    if (selectedDocId == null) return;

    await firestore.collection("users").doc(selectedDocId).update({
      "name": nameController.text,
      "city": cityController.text,
    });

    selectedDocId = null;
    nameController.clear();
    cityController.clear();
  }

  // DELETE
  Future<void> deleteUser(String docId) async {
    await firestore.collection("users").doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase CRUD"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // INPUT FIELDS
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            // BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addUser,
                    child: const Text("Add"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: updateUser,
                    child: const Text("Update"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            // READ DATA (LIST)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection("users").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No data found"));
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var data = docs[index];
                      String docId = data.id;

                      return Card(
                        child: ListTile(
                          title: Text(data["name"]),
                          subtitle: Text(data["city"]),
                          leading: const Icon(Icons.person),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // EDIT BUTTON
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  selectedDocId = docId;
                                  nameController.text = data["name"];
                                  cityController.text = data["city"];
                                },
                              ),

                              // DELETE BUTTON
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteUser(docId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
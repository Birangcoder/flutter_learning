import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class UploadProgress with ChangeNotifier {
  double _progress = 0.0;
  double get progress => _progress;

  File? _selectedFile;
  File? get selectedFile => _selectedFile;

  /// Pick file from device
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      _selectedFile = File(result.files.single.path!);
      notifyListeners();
    }
  }

  /// Upload file
  Future<void> uploadFile() async {
    if (_selectedFile == null) return;

    _progress = 0;
    notifyListeners();

    final dio = Dio();

    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        _selectedFile!.path,
        filename: _selectedFile!.path.split('/').last,
      ),
    });

    await dio.post(
      "https://httpbin.org/post", // demo upload API
      data: formData,
      onSendProgress: (sent, total) {
        if (total != -1) {
          _progress = sent / total * 100;
          notifyListeners();
        }
      },
    );
  }
}

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("File Upload")),
      body: const Center(child: UploadWidget()),
    );
  }
}

class UploadWidget extends StatelessWidget {
  const UploadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UploadProgress>(
      builder: (context, status, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Progress: ${status.progress.toStringAsFixed(1)} %",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: status.pickFile,
              child: const Text("Pick File"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed:
              status.selectedFile == null ? null : status.uploadFile,
              child: const Text("Upload File"),
            ),
          ],
        );
      },
    );
  }
}

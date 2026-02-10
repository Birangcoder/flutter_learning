import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProgress with ChangeNotifier {
  var _progress = 0.0;

  double get progress => _progress;

  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    }
    return await getApplicationDocumentsDirectory();
  }

  void start({required String url, required String filename}) async {
    _resetProgress();

    final directory = await getDownloadDirectory();
    final pathName = "${directory.path}/$filename";

    await Dio().download(
      url,
      pathName,
      options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          var pos = received / total * 100;
          _updateProgress(pos);
        }
      },
    );

    // print("Downloaded to: $pathName");
  }

  void _resetProgress() {
    if (_progress != 0) {
      _progress = 0;
      notifyListeners();
    }
  }

  void _updateProgress(double value) {
    _progress = value;
    notifyListeners();
  }
}

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Demo Download")),
      body: const Center(child: DownloadWidget()),
    );
  }
}

class DownloadWidget extends StatelessWidget {
  final String url =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  const DownloadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadProgress>(
      builder: (context, status, _) {
        var progress = status.progress.toStringAsFixed(1);

        return ElevatedButton(
          child: Text("$progress %"),
          onPressed: () => status.start(url: url, filename: "myfile.pdf"),
        );
      },
    );
  }
}

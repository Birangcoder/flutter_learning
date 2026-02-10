import 'package:flutter/material.dart';
import "dart:convert";
import 'package:xml/xml.dart';
// import 'package:camera/camera.dart';

// import 'camera.dart';
import 'package:provider/provider.dart';
import 'animation/implicit_animation.dart';
import 'animation/explicit_animation.dart';
import 'animation/explicit_method.dart';
import 'animation/flutterHooks.dart';
import 'animation/hero_fade_slide.dart';
import 'widgets/ImageFromWeb.dart';

// import 'widgets/AudioPlayer.dart';
import 'widgets/VideoPlayer.dart';
import 'widgets/videoPlay.dart';
import 'widgets/YoutubeVideo.dart';
import 'input/loginForm.dart';
import 'input/registration.dart';
import 'input/gesture.dart';
import 'input/dragDrop.dart';

import 'tabBar.dart';
import 'StepperExample.dart';

import 'cupertino/ActionSheetDemo.dart';

import 'network/HTTP_request/fetchData.dart';
import 'network/HTTP_request/sendData.dart';
import 'network/working_data/download_progress.dart';
import 'network/working_data/upload_file.dart';
// import 'deviceInteraction/camera.dart';

// late List<CameraDescription> cameras;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   runApp(MyApp(cameras: cameras));
// }

void main() {
  runApp(const MyApp());
}

// 1.
class MyApp extends StatelessWidget {
  // final List<CameraDescription> cameras;

  // const MyApp({super.key, required this.cameras});
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomePage(cameras: cameras),
      home: HomePage(),
    );
  }
}

class jsonData {
  final jsonString = '{ "id": 1, "name": "Alberto" }';
  late final decodedMap = jsonDecode(jsonString);
  late final user = Person.fromJson(decodedMap);

  // print("${user.id}"); // prints "1"
  // print("${user.value}"); // prints "Alberto"
  late final json = jsonEncode(user);
  // print(json); // prints "{'id': 1, 'name': 'Alberto'}"
}

class xmlData {
  String xmlString = '''
    <user>
      <id>1</id>
      <name>Birang</name>
      <email>birang@gmail.com</email>
    </user>
    ''';
}

class Person {
  final int id;
  final String value;

  // 1.
  Person._({required this.id, required this.value});

  // 2.
  factory Person.fromJson(Map<String, dynamic> json) =>
      Person._(id: json["id"], value: json["name"]);

  // 3.
  Map<String, dynamic> toJson() => {"id": id, "name": value};

  @override
  String toString() => "$id- $value";
}

class HomePage extends StatelessWidget {
  // final List<CameraDescription> cameras;

  // const HomePage({super.key, required this.cameras});
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    xmlData xd = xmlData();
    final document = XmlDocument.parse(xmlData().xmlString);
    final name = document.findAllElements('name').first.text;
    final email = document.findAllElements('email').first.text;

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            // Text("$name"),
            // Text("$email"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ImpAnimation()),
                );
              },
              child: Text("implicit button"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpAnimation()),
                );
              },
              child: Text("Explicit button"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimationDemo()),
                );
              },
              child: Text("Explicit Method"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text("Hero Fade Slide"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ImageFromWeb()),
                );
              },
              child: Text("Image From Network"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const AudioPlayerPage(),
            //       ),
            //     );
            //   },
            //   child: Text("Audio Player"),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VideoPlayerScreen()),
                );
              },
              child: const Text("Video Player list"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VideoPlay()),
                );
              },
              child: const Text("Video Play"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YoutubeVideoScreen(),
                  ),
                );
              },
              child: Text("Youtube Video Player"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginForm()),
                );
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentRegistrationForm(),
                  ),
                );
              },
              child: Text("Register"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SwipeItems()),
                );
              },
              child: Text("Swip Gesture"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExampleDragAndDrop(),
                  ),
                );
              },
              child: Text("Drag Drop Gesture"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             TakePictureScreen(camera: cameras.first),
            //       ),
            //     );
            //   },
            //   child: const Text("Camera"),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActionSheetDemo()),
                );
              },
              child: const Text("Action Sheet Demo"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Example()),
                );
              },
              child: Text("Flutter Hooks"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TabsExample()),
                );
              },
              child: Text("Tabs Example"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StepperControlExample(),
                  ),
                );
              },
              child: Text("Stepper Example"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => fetchData()),
                );
              },
              child: Text("fetchData Example"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => sendData()),
                );
              },
              child: Text("sendData Example"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => DownloadProgress(),
                      child: const DownloadScreen(),
                    ),
                  ),
                );
              },
              child: const Text("Download Progress Example"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChangeNotifierProvider(
                      create: (_) => UploadProgress(),
                      child: const UploadScreen(),
                    ),
                  ),
                );
              },
              child: const Text("Upload File Example"),
            ),
          ],
        ),
      ),
    );
  }
}

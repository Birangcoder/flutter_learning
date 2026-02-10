// import 'package:flutter/material.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
//
// class AudioPlayerPage extends StatefulWidget {
//   const AudioPlayerPage({super.key});
//
//   @override
//   State<AudioPlayerPage> createState() => _AudioPlayerPageState();
// }
//
// class _AudioPlayerPageState extends State<AudioPlayerPage> {
//   final AssetsAudioPlayer _player = AssetsAudioPlayer();
//   bool isPlaying = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _player.open(
//       Playlist(
//         audios: [
//           Audio("assets/music/Kashi_Vishwanath_Ki_Mahima.webm"),
//           Audio("assets/music/Dammar_Daak_5_(Dakla).webm"),
//           Audio("assets/music/Gir_Gajavti_Aavi_Sinhan.webm"),
//         ],
//       ),
//       autoStart: true,
//     );
//   }
//
//   @override
//   void dispose() {
//     _player.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Audio Player")),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.skip_previous),
//               onPressed: _player.previous,
//             ),
//             AnimatedCrossFade(
//               firstChild: IconButton(
//                 icon: const Icon(Icons.play_arrow),
//                 onPressed: () {
//                   setState(() => isPlaying = true);
//                   _player.play();
//                 },
//               ),
//               secondChild: IconButton(
//                 icon: const Icon(Icons.pause),
//                 onPressed: () {
//                   setState(() => isPlaying = false);
//                   _player.pause();
//                 },
//               ),
//               crossFadeState: isPlaying
//                   ? CrossFadeState.showSecond
//                   : CrossFadeState.showFirst,
//               duration: const Duration(milliseconds: 300),
//             ),
//             IconButton(
//               icon: const Icon(Icons.skip_next),
//               onPressed: _player.next,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ImageFromWeb extends StatelessWidget {
  // final List<String> url;

  const ImageFromWeb();

  @override
  Widget build(BuildContext context) {
    final List<String> url = [
      "https://ik.imagekit.io/gamestore/601552-conan-exiles-xbox-one-front-cover.jpg?updatedAt=1744540879840",
      "https://ik.imagekit.io/gamestore/Black_Myth_Wukong_cover_art.jpg?updatedAt=1726218655398",
      "https://ik.imagekit.io/gamestore/OIP.rgm7QULQclon8hsxmbgssgHaJ4_rs=1&pid=ImgDetMain?updatedAt=1724667243793",
      "https://ik.imagekit.io/gamestore/image.png?updatedAt=1724667127800",
      "https://ik.imagekit.io/gamestore/Life_Is_Strange_cover_art.png?updatedAt=1724667018393",
      "https://ik.imagekit.io/gamestore/Darksiders-II-Deathinitive-Edition-Free-Download-Repacklab-1.jpg?updatedAt=1724666912920",
      "https://ik.imagekit.io/gamestore/OIP.U6VEDfld3oS5zNtooZgKnQHaLH_rs=1&pid=ImgDetMain?updatedAt=1724666782257",
      "https://ik.imagekit.io/gamestore/Darksiders_3_Box_Art.png?updatedAt=1724666608306",
    ];
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: url.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 150,
              width: 150,
              child: Image.network(
                fit: BoxFit.fitHeight,
                url[index],
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            );
          }
        ),
      ),
    );
  }
}

import 'package:imgur/imgur.dart' as imgur;
import 'dart:async';

Future<String> uploadImage(String path) async {
  final client = imgur.Imgur(imgur.Authentication());
  print(path);
  String imglink;

  /// Upload an image from path
  await client.image
      .uploadImage(
          imagePath: path, title: 'A title', description: 'A description')
      .then((image) {
    print('Uploaded image to: ${image.link}');
    imglink = image.link;
  });
  return Future.value(imglink);
}

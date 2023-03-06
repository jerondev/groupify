import 'package:image_cropper/image_cropper.dart';

Future<String?> cropImage(String imagePath) async {
  final croppedImage = await ImageCropper().cropImage(
      sourcePath: imagePath,
      uiSettings: [AndroidUiSettings(toolbarTitle: "Crop Community Profile")]);
  return croppedImage?.path;
}

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

Future<String?> uploadImageToFirebaseStorage(String imagePath) async {
  // Create a reference to the Firebase Storage location
  String fileName = path.basename(imagePath);
  final Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

  // Upload the file to Firebase Storage
  try {
    final UploadTask uploadTask = storageRef.putFile(File(imagePath));
    await uploadTask.whenComplete(() {});
    // Get the download URL of the uploaded file
    final String downloadURL = await storageRef.getDownloadURL();
    // Return the download URL
    return downloadURL;
  } catch (e) {
    print('Error uploading image to Firebase Storage: ${e.toString()}');
    return null;
  }
}

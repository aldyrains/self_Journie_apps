import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class ImageServices {
  ImageServices._();

  static FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadImageToFireStorage(
      {required Uint8List image,
      required String userID, required String imageNotes
      }) async {
    var uniqueID = const Uuid().v4();
    Reference upload = storage.ref('$imageNotes/${uniqueID}_${userID}.png');
    UploadTask uploadTask = upload.putData(image);
    var downloadUrl =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    print('downloadurl: ${downloadUrl.toString()}');
    return downloadUrl.toString();
  }

  static Future<File> compressImage(File file) async {
    File compressedImage = await FlutterNativeImage.compressImage(
      file.path,
      quality: 25,
    );
    return compressedImage;
  }
}
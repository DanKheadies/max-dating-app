import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/repositories/storage/base_storage_repository.dart';

class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Future<void> uploadImage(
    User user,
    XFile image,
  ) async {
    try {
      await storage
          .ref('${user.id}/${image.name}')
          .putFile(
            File(image.path),
          )
          .then(
            (snap) => DatabaseRepository().updateUserPictures(user, image.name),
          );
    } catch (_) {}
  }

  @override
  Future<String> getDownloadUrl(
    User user,
    String imageName,
  ) async {
    String downloadUrl =
        await storage.ref('${user.id}/$imageName').getDownloadURL();

    return downloadUrl;
  }
}

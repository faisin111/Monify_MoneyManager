import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

class ImageService {
  final Box _box = Hive.box('salary');

  File? loadImage(String? uuid) {
    final path = _box.get('profile_image_$uuid');
    if (path != null) {
      return File(path);
    }
    return null;
  }

  Future<File?> pickImage(String? uuid) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return null;

    await _box.put('profile_image_$uuid', picked.path);
    return File(picked.path);
  }

  Future<bool?> deleteImage(String? uuid) async {
    final result=_box.get("profile_image_$uuid",defaultValue: false);
    if(result==false)return false;
    await _box.delete('profile_image_$uuid');
    return true;
  }
}

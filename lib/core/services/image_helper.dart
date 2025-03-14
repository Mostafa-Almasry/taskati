import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<String?> pickImage(bool isCamera) async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    return pickedImage?.path;
  }
}

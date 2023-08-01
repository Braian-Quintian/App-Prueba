import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<String?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    return pickedFile?.path;
  }
}

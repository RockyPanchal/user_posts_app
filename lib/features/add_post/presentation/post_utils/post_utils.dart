import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_posts_app/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:user_posts_app/features/add_post/presentation/bloc/add_post_events.dart';


class PostUtils {

  static Future<void> _getImage(BuildContext context, AddPostsBloc bloc, ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      bloc.add(AddPostImageEvent(imagePath:pickedFile.path));
    } else {
      debugPrint('No image selected.');
    }
  }


  static Future<void> showImagePickerDialog(BuildContext context, AddPostsBloc postBloc) async {
    return await showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              _getImage(context,postBloc , ImageSource.camera);
            },
            isDefaultAction: true,
            child: const Text(
              'Take a Picture',
              style: TextStyle(fontSize: 16),
            ),
          ),
          CupertinoActionSheetAction(
            child: const Text(
              'Choose from Gallery',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              Navigator.pop(context);
              _getImage(context,postBloc , ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_posts_app/features/post_screen/data/post_model.dart';
import 'package:user_posts_app/features/post_screen/domain/post_entity.dart';

class FirebaseDatabaseProvider {
  static final FirebaseDatabaseProvider shared =
      FirebaseDatabaseProvider._internal();

  FirebaseDatabaseProvider._internal();

  factory FirebaseDatabaseProvider() {
    return shared;
  }

  PostEntity createPost(PostModel postModel) {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('posts');
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    databaseReference.push().set({
      'userId': 1,
      'userName': 'Rocky',
      'userProfile': '',
      'postTime': currentTimeStamp,
      'postTitle': postModel.title,
      'postDescription': postModel.description,
      'postImage': postModel.imagePath,
    });
    return PostEntity(userId: 1, userName: 'Rocky', userProfile: '', postTime: currentTimeStamp, title: postModel.title, description: postModel.description, imagePath: postModel.imagePath);
  }

  Future<List<PostEntity>> readData() async {
    List<PostEntity> posts = [];
    try{
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('posts');
      final snapshot = await databaseReference.get();
      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, values) {
          posts.add(PostEntity.fromMap(values as Map<dynamic, dynamic>));
        });
        posts.sort((a, b) => a.postTime.compareTo(b.postTime));
        posts = posts.reversed.toList();
        debugPrint("${snapshot.value}");
      } else {
        debugPrint('No data available.');
      }
    }catch(e){
      debugPrint(e.toString());
    }
    return posts;
  }

  Future<String> addImageToFirebase(String path) async {
    //Get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('post_images');

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //Create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(path));
      //Success: get the download URL
      var imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (error) {
      throw Exception(error);
    }
  }
}

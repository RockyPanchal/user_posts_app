import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:user_posts_app/core/firebase/firebase_database_provider.dart';
import 'package:user_posts_app/features/post_screen/data/post_model.dart';
import 'package:user_posts_app/features/post_screen/domain/post_entity.dart';

import 'add_post_events.dart';
import 'add_post_states.dart';


class AddPostsBloc extends Bloc<AddPostsEvent, AddPostsState> {

  AddPostsBloc() : super(AddPostInitialState()) {
    on<AddPostEvent>(_onAddPostEvent);
    on<AddPostImageEvent>(_onAddPostImageEvent);
  }


  FutureOr<void> _onAddPostEvent(
      AddPostEvent event, Emitter<AddPostsState> emit) async {
    PostModel postModel = event.post;
    emit(AddPostLoadingState());
    try {
      File file = File(postModel.imagePath);
      final compressImage = await FlutterNativeImage.compressImage(Uri.encodeFull(file.absolute.path),
          quality: 30, percentage: 50);
      String imgPath = await FirebaseDatabaseProvider.shared
          .addImageToFirebase(compressImage.path);
      postModel.imagePath = imgPath;
      PostEntity postEntity = FirebaseDatabaseProvider.shared.createPost(postModel);
      emit(PostsAddedState(postEntity));
    } catch (e) {
      emit(AddPostsErrorState());
    }
  }

  FutureOr<void> _onAddPostImageEvent(
      AddPostImageEvent event, Emitter<AddPostsState> emit) async {
    emit(AddPostImageState(event.imagePath));
  }

}

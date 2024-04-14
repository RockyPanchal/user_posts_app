
import 'package:user_posts_app/features/post_screen/domain/post_entity.dart';

abstract class AddPostsState {}

class AddPostInitialState extends AddPostsState {}

class AddPostLoadingState extends AddPostsState {}

class AddPostsErrorState extends AddPostsState {}

class AddPostImageState extends AddPostsState {
  final String? imagePath;
  AddPostImageState(this.imagePath);
}

class PostsAddedState extends AddPostsState {
  final PostEntity post;
  PostsAddedState(this.post);
}


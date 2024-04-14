
import 'package:user_posts_app/features/post_screen/data/post_model.dart';

abstract class AddPostsEvent {}


class AddPostEvent extends AddPostsEvent {
  final PostModel post;
  AddPostEvent(this.post);
}

class AddPostImageEvent extends AddPostsEvent {
  final String? imagePath;
  AddPostImageEvent({this.imagePath});
}



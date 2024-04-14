import 'package:user_posts_app/features/post_screen/domain/post_entity.dart';

abstract class PostsEvent {}

class LoadPostsEvent extends PostsEvent {}

class UpdatePostsEvent extends PostsEvent {
  final PostEntity post;
  UpdatePostsEvent(this.post);
}


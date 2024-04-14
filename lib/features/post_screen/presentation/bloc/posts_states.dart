
import 'package:user_posts_app/features/post_screen/domain/post_entity.dart';

abstract class PostsState {}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<PostEntity> posts;
  PostsLoadedState(this.posts);
}

class PostsErrorState extends PostsState {}


class PostsUpdateState extends PostsState {
  final PostEntity post;
  PostsUpdateState(this.post);
}

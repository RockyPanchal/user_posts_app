import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_posts_app/core/firebase/firebase_database_provider.dart';
import 'package:user_posts_app/features/post_screen/domain/post_entity.dart';
import 'posts_events.dart';
import 'posts_states.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  List<PostEntity> posts = [];

  PostsBloc() : super(PostsInitialState()) {
    on<LoadPostsEvent>(_onLoadPostsEvent);
    on<UpdatePostsEvent>(_onUpdatePostsEvent);
  }

  FutureOr<void> _onLoadPostsEvent(
      LoadPostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    try {
      // Load posts from Firebase
      Future.delayed(const Duration(seconds: 5));
      posts = await FirebaseDatabaseProvider.shared.readData();
      emit(PostsLoadedState(posts));
    } catch (e) {
      emit(PostsErrorState());
    }
  }

  FutureOr<void> _onUpdatePostsEvent(UpdatePostsEvent event, Emitter<PostsState> emit) {
    posts.insert(0, event.post);
    emit(PostsLoadedState(posts));
   // emit(PostsUpdateState(event.post));
  }
}

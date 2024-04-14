import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_posts_app/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:user_posts_app/features/add_post/presentation/screens/add_post_screen.dart';
import 'package:user_posts_app/features/post_screen/presentation/bloc/posts_bloc.dart';
import 'package:user_posts_app/features/post_screen/presentation/bloc/posts_events.dart';
import 'package:user_posts_app/features/post_screen/presentation/bloc/posts_states.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {

 late PostsBloc postsBloc;

  @override
  void initState() {
    super.initState();
    postsBloc = BlocProvider.of<PostsBloc>(context);
    postsBloc.add(LoadPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timeline')),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostsLoadedState) {
            return ListView.builder(
              itemCount: state.posts.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Card(
                    elevation: 1,// Using a Card for visual structure
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row( // For user data
                            children: [
                              post.userProfile.isNotEmpty? CircleAvatar(
                                backgroundImage: NetworkImage(post.userProfile), // Assuming userProfile is an image URL
                                radius: 20,
                              ):const Icon(Icons.person),
                              const SizedBox(width: 10),
                              Text(
                                post.userName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            post.title,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Text(post.description),
                          const SizedBox(height: 8),
                           if(post.imagePath.isNotEmpty && post.imagePath != 'null')
                            CachedNetworkImage(
                             imageUrl: post.imagePath,
                             placeholder: (context, url) =>  Shimmer.fromColors(
                               baseColor: Colors.black12,
                               highlightColor: Colors.black26, child: Container(
                               height: 150,
                               color: Colors.white24,
                             ),
                             ),
                           ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No Posts Found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                    create: (context) => AddPostsBloc(),
                    child:  AddPostScreen(postsBloc: postsBloc,))),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

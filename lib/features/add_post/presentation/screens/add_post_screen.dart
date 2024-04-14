import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_posts_app/common_widgets/inkwell_widget.dart';
import 'package:user_posts_app/common_widgets/text_field_widget.dart';
import 'package:user_posts_app/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:user_posts_app/features/add_post/presentation/bloc/add_post_events.dart';
import 'package:user_posts_app/features/add_post/presentation/bloc/add_post_states.dart';
import 'package:user_posts_app/features/add_post/presentation/post_utils/post_utils.dart';
import 'dart:io';
import 'package:user_posts_app/features/post_screen/data/post_model.dart';
import 'package:user_posts_app/features/post_screen/presentation/bloc/posts_bloc.dart';
import 'package:user_posts_app/features/post_screen/presentation/bloc/posts_events.dart';

class AddPostScreen extends StatefulWidget {
  final PostsBloc postsBloc;
  const AddPostScreen({super.key, required this.postsBloc});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String imagePath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Post')),
      body: BlocListener<AddPostsBloc, AddPostsState>(
        listener: (context,state){
          if(state is PostsAddedState){
            widget.postsBloc.add(UpdatePostsEvent(state.post));
            Navigator.of(context).pop();
            Future.delayed(const Duration(milliseconds: 200),(){
              Navigator.of(context).pop();
            });
          }else if(state is AddPostLoadingState){
            showDialog(
              context: context,
              barrierColor: Colors.transparent,
              barrierDismissible: false,
              builder: (BuildContext context) => const Center(child: CircularProgressIndicator()),
            );
          }
        },
        child: SingleChildScrollView( // To prevent overflow when the keyboard is open
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormFieldWidget(
                    controller: _titleController,
                    labelText: 'Title',
                    validatorMessage: 'Please enter Title',
                  ),
                  const SizedBox(height: 15),
                  TextFormFieldWidget(
                    controller: _descriptionController,
                    maxLines: null,
                    labelText: 'Description',
                    validatorMessage: 'Please enter Description',
                  ),
                  const SizedBox(height: 50),
                  BlocBuilder<AddPostsBloc, AddPostsState>(
                    builder: (context, state) {
                      imagePath = state is AddPostImageState
                          ? state.imagePath ?? ''
                          : imagePath;
                      File? image = imagePath.isNotEmpty ? File(imagePath) : null;
                      return InkWellWidget(
                        onTap: () => PostUtils.showImagePickerDialog(context,BlocProvider.of<AddPostsBloc>(context)),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black38, // Set border color
                              width: 1.0,       // Set border width
                            ),
                            image:image !=null? DecorationImage(
                                image: FileImage(image)

                            ):null
                          ),
                            child:  const Icon(Icons.add),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => onTapAddPost(context),
                      child: const Text('Add Post'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapAddPost(BuildContext context)async{
    if(_formKey.currentState!.validate()){
      PostModel postModel = PostModel(_titleController.text, _descriptionController.text, imagePath);
      BlocProvider.of<AddPostsBloc>(context).add(AddPostEvent(postModel));
    }
  }
}

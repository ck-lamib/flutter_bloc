import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/post/presentation/view/post_liist.dart';

import '../bloc/post_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc list"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => PostBloc()..add(FetchPost()),
        child: const PostList(),
      ),
    );
  }
}

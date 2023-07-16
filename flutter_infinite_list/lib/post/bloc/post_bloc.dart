import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/post/model/post.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<FetchPost>(_onFetchPost);
  }

  FutureOr<void> _onFetchPost(FetchPost event, Emitter<PostState> emit) async {
    try {
      if (state.hasMaxLimit) return;
      if (state.postStatus == PostStatus.initial) {
        var posts = await loadPost();
        return emit(
          state.copyWith(
            hasMaxLimit: false,
            postStatus: PostStatus.success,
            posts: posts,
          ),
        );
      }
      var posts = await loadPost(startIndex: state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasMaxLimit: true))
          : emit(state.copyWith(
              hasMaxLimit: false,
              postStatus: PostStatus.success,
              // posts: List.of(state.posts)..addAll(posts),
              posts: [...state.posts, ...posts],
            ));
    } catch (e) {
      emit(state.copyWith(
        postStatus: PostStatus.failed,
      ));
    }
  }

  Future<List<Post>> loadPost({int startIndex = 0}) async {
    // var url = Uri.parse("https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20");
    var url = Uri.https(
        "jsonplaceholder.typicode.com", "/posts", {'_start': "$startIndex", '_limit': "20"});
    log("====================>>>>post fetch url: $url");
    http.Response response = await http.get(url);

    var decodedList = jsonDecode(response.body);
    var postList = postsFromJson(decodedList);
    return postList;
  }
}

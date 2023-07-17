import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/post/data/model/post.dart';
import 'package:flutter_infinite_list/post/domain/post_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const PostState()) {
    on<FetchPost>(
      _onFetchPost,
    );
  }

  FutureOr<void> _onFetchPost(FetchPost event, Emitter<PostState> emit) async {
    try {
      if (state.hasMaxLimit) return;
      if (state.postStatus == PostStatus.initial) {
        var posts = await PostRepo.loadPost();
        return emit(
          state.copyWith(
            hasMaxLimit: false,
            postStatus: PostStatus.success,
            posts: posts,
          ),
        );
      }
      var posts = await PostRepo.loadPost(startIndex: state.posts.length);
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
}

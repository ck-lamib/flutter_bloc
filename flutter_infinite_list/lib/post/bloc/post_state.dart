part of 'post_bloc.dart';

class PostState extends Equatable {
  final PostStatus postStatus;
  final List<Post> posts;
  final bool hasMaxLimit;

  const PostState(
      {this.postStatus = PostStatus.initial,
      this.posts = const <Post>[],
      this.hasMaxLimit = false});

  PostState copyWith({
    PostStatus? postStatus,
    List<Post>? posts,
    bool? hasMaxLimit,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,
      posts: posts ?? this.posts,
      hasMaxLimit: hasMaxLimit ?? this.hasMaxLimit,
    );
  }

  @override
  List<Object> get props => [postStatus, posts, hasMaxLimit];
}

enum PostStatus { initial, success, failed }

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];
}

List<Post> postsFromJson(List<dynamic> postJsons) =>
    postJsons.map((e) => Post(id: e["id"], title: e["title"], body: e["body"])).toList();

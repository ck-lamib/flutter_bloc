import 'package:flutter/material.dart';

import '../../data/model/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      decoration: BoxDecoration(
        color: post.id.isEven ? Colors.amber[200] : Colors.amber[500],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(post.title),
        titleTextStyle: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        isThreeLine: true,
        subtitle: Text(post.body),
        subtitleTextStyle: textTheme.bodySmall,
        dense: true,
      ),
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import '../data/model/post.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  static Future<List<Post>> loadPost({int startIndex = 0}) async {
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

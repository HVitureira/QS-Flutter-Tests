import 'package:dio/dio.dart';
import 'package:flutter_qualidade_software/models/post.dart';

class PostsRepository {
  PostsRepository({this.httpClient}) {
    httpClient ??= Dio();
  }

  Dio? httpClient;

  Future<List<Post>> getPosts({bool isMock = false}) async {
    if (isMock) {
      return List<Post>.generate(
        3,
        (index) => Post(
          id: '$index',
          text: 'post $index',
          views: index,
        ),
      );
    } else {
      final res = await httpClient!.get('api/posts');
      List<dynamic> data = res.data;
      final posts = List<Post>.generate(
        data.length,
        (index) => Post.fromJson(data[index]),
      );
      return posts;
    }
  }
}

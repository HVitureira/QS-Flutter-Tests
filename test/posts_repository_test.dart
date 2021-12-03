import 'package:dio/dio.dart';
import 'package:flutter_qualidade_software/api/posts_repository.dart';
import 'package:flutter_qualidade_software/models/post.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  PostsRepository? postsRepository;
  Dio? mockDio;

  setUp(() {
    mockDio = MockDio();
    postsRepository = PostsRepository(httpClient: mockDio);
  });

  test('get mock posts', () async {
    final posts = await postsRepository!.getPosts(isMock: true);
    expect(posts, const [
      Post(id: '0', text: 'post 0', views: 0),
      Post(id: '1', text: 'post 1', views: 1),
      Post(id: '2', text: 'post 2', views: 2),
    ]);
  });

  test('get real posts', () async {
    when(() => mockDio!.get('api/posts')).thenAnswer((_) => Future.value(
          Response(
            data: [
              {
                'id': '3',
                'text': 'post 3',
                'views': 3,
              },
              {
                'id': '4',
                'text': 'post 4',
                'views': 4,
              }
            ],
            requestOptions: RequestOptions(path: 'api/posts'),
          ),
        ));

    final posts = await postsRepository!.getPosts(isMock: false);
    expect(posts, const [
      Post(id: '3', text: 'post 3', views: 3),
      Post(id: '4', text: 'post 4', views: 4),
    ]);
  });
}

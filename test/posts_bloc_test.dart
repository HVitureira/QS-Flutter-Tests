import 'package:flutter_qualidade_software/api/posts_repository.dart';
import 'package:flutter_qualidade_software/models/post.dart';
import 'package:flutter_qualidade_software/posts_bloc/posts_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  PostsBloc? bloc;
  PostsRepository? mockPostsRepository;
  final _initialState = PostsInitial();

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    bloc = PostsBloc(postsRepository: mockPostsRepository);
  });

  group('states', () {
    test('initial state is correct', () async {
      expect(bloc!.state, _initialState);
    });

    blocTest<PostsBloc, PostsState>(
      'emits [PostsFetchInProgress, PostsFetchSuccess] when PostsRetrieve is added.',
      build: () {
        when(() => mockPostsRepository!.getPosts(isMock: true)).thenAnswer(
          (_) => Future.value(const [
            Post(id: '1', text: 'post 1', views: 1),
            Post(id: '2', text: 'post 2', views: 2)
          ]),
        );
        return bloc!;
      },
      act: (bloc) async {
        bloc.add(PostsRetrieve(isMock: true));
        await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
      },
      seed: () => _initialState,
      expect: () => [
        PostsFetchInProgress(),
        PostsFetchSuccess(
          posts: const [
            Post(id: '1', text: 'post 1', views: 1),
            Post(id: '2', text: 'post 2', views: 2),
          ],
        ),
      ],
    );
  });
}

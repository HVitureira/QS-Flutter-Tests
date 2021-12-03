import 'package:bloc/bloc.dart';
import 'package:flutter_qualidade_software/api/posts_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_qualidade_software/models/post.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository? postsRepository;

  PostsBloc({this.postsRepository}) : super(PostsInitial()) {
    on<PostsRetrieve>((event, emit) async {
      emit(PostsFetchInProgress());
      await Future.delayed(const Duration(seconds: 2)); //mock api lag
      final posts = await postsRepository!.getPosts(isMock: event.isMock);
      emit(PostsFetchSuccess(posts: posts));
    });
  }
}

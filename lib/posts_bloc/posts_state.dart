part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  @override
  List<Object?> get props => [];
}

class PostsFetchInProgress extends PostsState {}

class PostsFetchSuccess extends PostsState {
  final List<Post> posts;

  PostsFetchSuccess({required this.posts});

  @override
  List<Object?> get props => [posts];
}

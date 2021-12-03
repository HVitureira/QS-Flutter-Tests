part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostsRetrieve extends PostsEvent {
  final bool isMock;

  PostsRetrieve({required this.isMock});

  @override
  List<Object?> get props => [isMock];
}

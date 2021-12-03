part of 'text_field_bloc.dart';

@immutable
abstract class TextFieldState extends Equatable {}

class TextFieldInitial extends TextFieldState {
  @override
  List<Object?> get props => [];
}

class TextFieldChangedSuccess extends TextFieldState {
  final String text;

  TextFieldChangedSuccess(this.text);
  @override
  List<Object?> get props => [text];
}

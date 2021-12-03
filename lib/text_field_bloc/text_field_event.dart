part of 'text_field_bloc.dart';

@immutable
abstract class TextFieldEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TextFieldValueChanged extends TextFieldEvent {
  TextFieldValueChanged(this.text);
  final String text;

  @override
  List<Object?> get props => [text];
}

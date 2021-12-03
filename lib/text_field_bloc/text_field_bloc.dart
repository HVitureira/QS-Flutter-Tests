import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'text_field_event.dart';
part 'text_field_state.dart';

class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc() : super(TextFieldInitial()) {
    on<TextFieldValueChanged>(
      (event, emit) => emit(TextFieldChangedSuccess(event.text)),
    );
  }
}

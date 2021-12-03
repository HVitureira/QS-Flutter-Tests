import 'package:flutter_qualidade_software/api/posts_repository.dart';
import 'package:flutter_qualidade_software/text_field_bloc/text_field_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  TextFieldBloc? bloc;
  final _initialState = TextFieldInitial();

  setUp(() {
    bloc = TextFieldBloc();
  });

  group('states', () {
    test('initial state is correct', () async {
      expect(bloc!.state, _initialState);
    });

    blocTest<TextFieldBloc, TextFieldState>(
      'emits [TextFieldValueChanged] when TextFieldValueChanged is added.',
      build: () => bloc!,
      act: (bloc) async {
        bloc.add(TextFieldValueChanged('some text'));
        await Future.delayed(const Duration(seconds: 2, milliseconds: 500));
      },
      seed: () => _initialState,
      expect: () => [
        TextFieldChangedSuccess('some text'),
      ],
    );
  });
}

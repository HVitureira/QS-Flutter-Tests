import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qualidade_software/extra_screen.dart';
import 'package:flutter_qualidade_software/posts_bloc/posts_bloc.dart';
import 'package:flutter_qualidade_software/text_field_bloc/text_field_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';

class MockPostsBloc extends MockBloc<PostsEvent, PostsState>
    implements PostsBloc {}

class MockTextFieldBloc extends MockBloc<TextFieldEvent, TextFieldState>
    implements TextFieldBloc {}

void main() {
  Widget? testingWidget;
  MockPostsBloc postsBloc = MockPostsBloc();
  MockTextFieldBloc textFieldBloc = MockTextFieldBloc();

  setUp(() {
    testingWidget = MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (context) => postsBloc,
        ),
        BlocProvider<TextFieldBloc>(
          create: (context) => textFieldBloc,
        )
      ],
      child: const MaterialApp(home: ExtraScreen()),
    );

    when(() => postsBloc.state).thenReturn(PostsInitial());
    when(() => textFieldBloc.state).thenReturn(TextFieldInitial());
  });

  testWidgets('show content', (tester) async {
    await tester.pumpWidget(testingWidget!);
    final appBar = find.byKey(const Key('extra_screen_appBar'));
    expect(appBar, findsOneWidget);

    final mockPostsButton = find.byKey(const Key('mock_posts_button'));
    expect(mockPostsButton, findsOneWidget);

    final realPostsButton = find.byKey(const Key('real_posts_button'));
    expect(realPostsButton, findsOneWidget);

    final textField = find.byKey(const Key('mutable_text_field'));
    expect(textField, findsOneWidget);

    final staticTextField = find.byKey(const Key('static_text_field'));
    expect(staticTextField, findsOneWidget);
    //check current cubit and bloc states
    expect(PostsInitial(), postsBloc.state);
  });

  testWidgets('tap mock posts button', (tester) async {
    await tester.pumpWidget(testingWidget!);

    final mockPostsButton = find.byKey(const Key('mock_posts_button'));
    expect(mockPostsButton, findsOneWidget);

    await tester.tap(mockPostsButton);
    await tester.pump();

    verify(() => postsBloc.add(PostsRetrieve(isMock: true)));
    verifyNever(() => postsBloc.add(PostsRetrieve(isMock: false)));
  });

  testWidgets('progress indicator shows', (tester) async {
    when(() => postsBloc.stream)
        .thenAnswer((_) => Stream.fromIterable([PostsFetchInProgress()]));
    await tester.pumpWidget(testingWidget!);
    await tester.pump(); //times needs to advance

    final circularIndicator =
        find.byKey(const Key('circle_progress_indicator'));
    expect(circularIndicator, findsOneWidget);
  });
}

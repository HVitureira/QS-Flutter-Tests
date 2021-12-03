import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'posts_bloc/posts_bloc.dart';
import 'text_field_bloc/text_field_bloc.dart';

class ExtraScreen extends StatefulWidget {
  const ExtraScreen({Key? key}) : super(key: key);

  @override
  _ExtraScreenState createState() => _ExtraScreenState();
}

class _ExtraScreenState extends State<ExtraScreen> {
  PostsBloc get postsBloc => BlocProvider.of<PostsBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          key: const Key('extra_screen_appBar'),
          title: const Text('Extra Screen'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        key: const Key('mock_posts_button'),
                        onPressed: () =>
                            postsBloc.add(PostsRetrieve(isMock: true)),
                        child: const Text('Get Mock Posts'),
                      ),
                      ElevatedButton(
                        key: const Key('real_posts_button'),
                        onPressed: () =>
                            postsBloc.add(PostsRetrieve(isMock: false)),
                        child: const Text('Get "Real" Posts'),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    if (state is PostsFetchInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(
                          key: Key('circle_progress_indicator'),
                        ),
                      );
                    }

                    if (state is PostsFetchSuccess) {
                      return Column(
                        children:
                            List<Card>.generate(state.posts.length, (index) {
                          final post = state.posts[index];
                          return Card(
                            child: SizedBox(
                              width: 500,
                              child: Column(
                                children: [
                                  Text('id: ${post.id.toString()}'),
                                  Text('text: ${post.text}'),
                                  Text('views: ${post.views.toString()}'),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    }
                    return Column(
                      children: [
                        TextField(
                          key: const Key('mutable_text_field'),
                          onChanged: (text) =>
                              BlocProvider.of<TextFieldBloc>(context).add(
                            TextFieldValueChanged(text),
                          ),
                        ),
                        BlocBuilder<TextFieldBloc, TextFieldState>(
                          builder: (context, state) {
                            return TextField(
                              key: const Key('static_text_field'),
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText: state is TextFieldChangedSuccess
                                    ? state.text
                                    : '',
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}

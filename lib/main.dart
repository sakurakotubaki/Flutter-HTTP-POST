import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_post_app/book_page.dart';
import 'package:http_post_app/domain/book_domain.dart';
import 'package:http_post_app/model/post_model.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

// 切り分けたWidgetで使うためのクラスを同じページに定義
// _futureBookでmodel.dartのクラスを引数に使う
class PostMethod {
  final TextEditingController _controller = TextEditingController();
  Future<PostModel>? _futureBook;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PostPage(),
    );
  }
}

class PostPage extends ConsumerWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postClass = new PostMethod();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('POSTメソッドでデータを追加'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: _HTTPWidget(postClass: postClass),
      ),
    );
  }
}

class _HTTPWidget extends StatelessWidget {
  const _HTTPWidget({
    Key? key,
    required this.postClass,
  }) : super(key: key);

  final PostMethod postClass;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: postClass._controller,
          decoration: const InputDecoration(hintText: '本のタイトルを入力'),
        ),
        ElevatedButton(
          onPressed: () {
            postClass._futureBook = createBook(postClass._controller.text);
          },
          child: const Text('本を追加'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookPage()),
              );
            },
            child: const Text('BookPage'))
      ],
    );
  }
}

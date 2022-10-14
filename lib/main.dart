import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http_post_app/domain/book_domain.dart';
import 'package:http_post_app/model/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  Future<BookList>? _futureBook;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: const Text('POSTメソッドでデータを追加'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          // 三項演算子で、nullだったら、入力フォームを表示する
          // 三項演算子で、nullじゃなかったら、サーバーのデータを表示したWidgetに切り替わる
          child: (_futureBook == null) ? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: '本のタイトルを入力'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureBook = createBook(_controller.text);
            });
          },
          child: const Text('本を追加'),
        ),
      ],
    );
  }

  FutureBuilder<BookList> buildFutureBuilder() {
    return FutureBuilder<BookList>(
      future: _futureBook,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}

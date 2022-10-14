import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_post_app/domain/book_provider.dart';

class BookPage extends ConsumerWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // このページで使用するriverpodを呼び出す変数を定義
    final value = ref.watch(booksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('mock-serverからデータを習得する'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: value.when(
            data: (books) {
              return ListView.builder(
                // 配列のデータを描画するWidget
                itemCount: books.length, // 配列の数をカウント
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(books[index].title), // 配列のtitleプロパティを表示
                  );
                },
              );
            },
            // データが習得できなかったら、ローディングされる.
            error: (err, stack) => Center(child: Text(err.toString())),
            loading: () => const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}

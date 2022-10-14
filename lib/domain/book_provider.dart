import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_post_app/model/get_model.dart';

// 自動でデータを再取得するよう設定するFutureProvider.
final booksProvider = FutureProvider<List<GetModel>>((ref) async {
  // model.dartの関数を呼び出す.
  return fetchPosts();
});

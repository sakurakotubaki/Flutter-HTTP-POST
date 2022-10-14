import 'package:http_post_app/model/post_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<BookList> createBook(String title) async {
  print('Riverpodで実行');
  final response = await http.post(
    Uri.parse('http://localhost:3000/bookList/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    print(response.statusCode);
    print(response.body);
    // サーバーが 201 CREATED レスポンスを返した場合。
    // JSON をパースします。
    return BookList.fromJson(jsonDecode(response.body));
  } else {
    // サーバーが 201 CREATED レスポンスを返さなかった場合。
    // 例外が発生する。
    throw Exception('Failed to create BookList.');
  }
}

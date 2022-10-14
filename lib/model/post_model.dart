class BookList {
  final int id;
  final String title;

  const BookList({required this.id, required this.title});

  factory BookList.fromJson(Map<String, dynamic> json) {
    return BookList(
      id: json['id'],
      title: json['title'],
    );
  }
}

class PostModel {
  final int id;
  final String title;

  const PostModel({required this.id, required this.title});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
    );
  }
}

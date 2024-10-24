class Post {
  Post({
    required this.id,
    required this.writer,
    required this.title,
    required this.content,
    required this.imgUrl,
    required this.createdAt,
  });

  final String id;
  final String writer;
  final String title;
  final String content;
  final String imgUrl;
  final DateTime createdAt;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      writer: json['writer'],
      title: json['title'],
      content: json['content'],
      imgUrl: json['imgUrl'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'writer': writer,
        'title': title,
        'content': content,
        'imgUrl': imgUrl,
        'createdAt': createdAt.toIso8601String(),
      };
}

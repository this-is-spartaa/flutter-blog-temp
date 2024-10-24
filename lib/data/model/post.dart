class Post {
  Post({
    required this.id,
    required this.writer,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final String writer;
  final String title;
  final String content;
  final DateTime createdAt;

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      writer: json['writer'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'writer': writer,
        'title': title,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };
}

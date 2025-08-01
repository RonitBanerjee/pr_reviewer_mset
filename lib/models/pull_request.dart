class PullRequest {
  final String title;
  final String body;
  final String author;
  final DateTime createdAt;

  PullRequest({
    required this.title,
    required this.body,
    required this.author,
    required this.createdAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) {
    return PullRequest(
      title: json['title'] ?? 'No title',
      body: json['body'] ?? '',
      author: json['user']['login'] ?? 'Unknown',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

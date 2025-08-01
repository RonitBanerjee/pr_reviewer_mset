class PullRequest {
  final String title;
  final String status;
  final String number;
  final String body;
  final String author;
  final DateTime createdAt;

  PullRequest({
    required this.title,
    required this.status,
    required this.number,
    required this.body,
    required this.author,
    required this.createdAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) {
    return PullRequest(
      title: json['title'] ?? 'No title',
      status: json['state'],
      number: json['number'].toString(),
      body: json['body'] ?? '',
      author: json['user']['login'] ?? 'Unknown',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

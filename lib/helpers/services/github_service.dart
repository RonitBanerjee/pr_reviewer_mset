import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:pr_reviewer/env/environment_constants.dart';
import 'package:pr_reviewer/models/pull_request.dart';

class GitHubService {
  final String token; // your GitHub access token
  final String owner;
  final String repo;

  GitHubService({required this.token, required this.owner, required this.repo});

  Future<List<PullRequest>?> fetchPullRequests() async {
    try {
      final url = Uri.parse("https://api.github.com/repos/$owner/$repo/pulls");
      print("Fetching from: $url");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // ← Important: use Bearer not token
          'Accept': 'application/vnd.github+json',
          'X-GitHub-Api-Version': '2022-11-28',
        },
      );

      print("Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        log(data.toString());
        return data.map((e) => PullRequest.fromJson(e)).toList();
      } else {
        print("Error: ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    return null;
  }
}

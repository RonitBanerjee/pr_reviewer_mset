import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pr_reviewer/env/environment_constants.dart';
import 'package:pr_reviewer/models/pull_request.dart';

class GitHubService {
  final String token; // your GitHub access token
  final String owner;
  final String repo;

  GitHubService({required this.token, required this.owner, required this.repo});

  Future<dynamic> fetchPullRequests() async {
    try {
      final url = Uri.parse(
        "${EnvironmentConstants.gitBaseUrl}/$owner/$repo/pulls",
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'token $token',
          'Accept': 'application/vnd.github+json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('data');
        return data.map((e) => PullRequest.fromJson(e)).toList();
      }
    } catch (e) {
      print(e);
    }
  }
}

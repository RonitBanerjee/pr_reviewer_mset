import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pr_reviewer/env/environment_constants.dart';
import 'package:pr_reviewer/helpers/services/github_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(loadInitialData);
  }

  FutureOr<void> loadInitialData(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    print('Here in home inital event');
    dynamic _pullRequests =
        await GitHubService(
          token: EnvironmentConstants.token,
          owner: 'ronitbanerjee',
          repo: 'pr_reviewer',
        ).fetchPullRequests();

    print('Pull Requests: ${_pullRequests}');
  }
}

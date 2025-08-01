part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final List<PullRequest> pullrequests;
  HomeLoadedState({required this.pullrequests});
}

final class HomeErrorState extends HomeState {}

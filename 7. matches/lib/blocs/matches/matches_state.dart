part of 'matches_bloc.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object?> get props => [];
}

class FetchingMatchesState extends MatchesState {}

class FetchedMatchesState extends MatchesState {
  final List<Match> matches;

  const FetchedMatchesState(this.matches);

  @override
  List<Object?> get props => [matches];
}

class NoMatchesState extends MatchesState {}

class ErrorMatchesState extends MatchesState {
  final String? errorMessage;

  const ErrorMatchesState([this.errorMessage]);

  @override
  List<Object?> get props => [errorMessage];
}

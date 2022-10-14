import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/models/match.dart';
import 'package:matches/errors/repository_error.dart';
import 'package:matches/repositories/matches_repository.dart';

part 'matches_event.dart';
part 'matches_state.dart';

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {
  final MatchesRepository matchesRepository;

  MatchesBloc({required this.matchesRepository})
      : super(FetchingMatchesState()) {
    on<FetchMatchesEvent>(_onFetch);
  }

  FutureOr<void> _onFetch(
      FetchMatchesEvent event, Emitter<MatchesState> emit) async {
    emit(FetchingMatchesState());

    try {
      final matches = await matchesRepository.matches(event.date);
      emit(matches.isEmpty ? NoMatchesState() : FetchedMatchesState(matches));
    } on RepositoryError catch (error) {
      emit(ErrorMatchesState(error.errorMessage));
    } catch (error) {
      emit(const ErrorMatchesState());
    }
  }

  void fetchMatches(DateTime date) => add(FetchMatchesEvent(date));
}

import 'package:intl/intl.dart';
import 'package:matches/errors/network_error.dart';
import 'package:matches/models/match.dart';
import 'package:matches/errors/repository_error.dart';
import 'package:matches/repositories/mappers/match_mapper.dart';
import 'package:matches/services/network/matches_service.dart';

class MatchesRepository {
  final MatchesService matchesService;
  final MatchMapper matchMapper;

  MatchesRepository({
    required this.matchesService,
    required this.matchMapper,
  });

  Future<List<Match>> matches(DateTime date) async {
    try {
      final response =
          await matchesService.matches(DateFormat('yyyy-MM-dd').format(date));

      return response.map(matchMapper.toModel).toList(growable: false);
    } on NetworkError catch (e) {
      throw RepositoryError(e.reasonPhrase);
    } catch (e) {
      throw RepositoryError();
    }
  }
}

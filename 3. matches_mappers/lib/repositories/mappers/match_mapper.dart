import 'package:matches/misc/mapper.dart';
import 'package:matches/models/match.dart';
import 'package:matches/services/network/dto/match_dto.dart';

class MatchMapper extends DTOMapper<MatchDTO, Match> {
  @override
  Match toModel(MatchDTO dto) => Match(
        referee: dto.details.referee,
        dateTime: dto.details.date,
        stadium: dto.details.venue.name,
        elapsed: dto.details.status.elapsed,
        league: League(
          name: dto.league.name,
          round: dto.league.round,
          imageUrl: dto.league.logo,
        ),
        teams: Teams(
          home: Team(
            name: dto.teams.home.name,
            logoUrl: dto.teams.home.logo,
            goals: dto.score.fulltime.home ?? dto.score.halftime.home ?? 0,
          ),
          away: Team(
            name: dto.teams.away.name,
            logoUrl: dto.teams.away.logo,
            goals: dto.score.fulltime.away ?? dto.score.halftime.away ?? 0,
          ),
        ),
        status: _mapMatchStatus(dto.details.status.short),
      );

  @override
  MatchDTO toTransferObject(Match model) {
    throw UnimplementedError();
  }

  MatchStatus? _mapMatchStatus(String short) {
    switch (short) {
      case 'TBD':
        return MatchStatus.tbd;
      case 'NS':
        return MatchStatus.ns;
      case '1H':
        return MatchStatus.fh;
      case 'HT':
        return MatchStatus.ht;
      case '2H':
        return MatchStatus.sh;
      case 'ET':
        return MatchStatus.et;
      case 'P':
        return MatchStatus.p;
      case 'FT':
        return MatchStatus.ft;
      case 'AET':
        return MatchStatus.aet;
      case 'PEN':
        return MatchStatus.pen;
      case 'BT':
        return MatchStatus.bt;
      case 'SUSP':
        return MatchStatus.susp;
      case 'INT':
        return MatchStatus.int;
      case 'PST':
        return MatchStatus.pst;
      case 'CANC':
        return MatchStatus.canc;
      case 'ABD':
        return MatchStatus.abd;
      case 'AWD':
        return MatchStatus.awd;
      case 'WO':
        return MatchStatus.wo;
      case 'LIVE':
        return MatchStatus.live;
    }

    return null;
  }
}

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MatchDTO extends Equatable {
  final DetailsDTO details;
  final LeagueDTO league;
  final TeamsDTO teams;
  final GoalsDTO goals;
  final ScoresDTO score;

  const MatchDTO({
    required this.details,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  factory MatchDTO.fromJson(Map<String, dynamic> data) => MatchDTO(
        details: DetailsDTO.fromJson(data['fixture']),
        league: LeagueDTO.fromJson(data['league']),
        teams: TeamsDTO.fromJson(data['teams']),
        goals: GoalsDTO.fromJson(data['goals']),
        score: ScoresDTO.fromJson(data['score']),
      );

  @override
  List<Object?> get props => [
        details,
        league,
        teams,
        goals,
        score,
      ];
}

class DetailsDTO extends Equatable {
  final int id;
  final String? referee;
  final String timezone;
  final DateTime date;
  final int timestamp;
  final VenueDTO venue;
  final StatusDTO status;

  const DetailsDTO({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.venue,
    required this.status,
  });

  factory DetailsDTO.fromJson(Map<String, dynamic> data) => DetailsDTO(
        id: data['id'],
        referee: data['referee'],
        timezone: data['timezone'],
        date: DateFormat('yyyy-MM-ddTHH:mm:ss+00:00').parse(data['date']),
        timestamp: data['timestamp'],
        venue: VenueDTO.fromJson(data['venue']),
        status: StatusDTO.fromJson(data['status']),
      );

  @override
  List<Object?> get props => [
        id,
        referee,
        timezone,
        date,
        timestamp,
        venue,
        status,
      ];
}

class VenueDTO extends Equatable {
  final int? id;
  final String? name;
  final String? city;

  const VenueDTO({
    required this.id,
    required this.name,
    required this.city,
  });

  factory VenueDTO.fromJson(Map<String, dynamic> data) => VenueDTO(
        id: data['id'],
        name: data['name'],
        city: data['city'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        city,
      ];
}

class StatusDTO extends Equatable {
  final String long;
  final String short;
  final int? elapsed;

  const StatusDTO({
    required this.long,
    required this.short,
    required this.elapsed,
  });

  factory StatusDTO.fromJson(Map<String, dynamic> data) => StatusDTO(
        long: data['long'],
        short: data['short'],
        elapsed: data['elapsed'],
      );

  @override
  List<Object?> get props => [
        long,
        short,
        elapsed,
      ];
}

class LeagueDTO extends Equatable {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String? flag;
  final int season;
  final String round;

  const LeagueDTO({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.round,
  });

  factory LeagueDTO.fromJson(Map<String, dynamic> data) => LeagueDTO(
        id: data['id'],
        name: data['name'],
        country: data['country'],
        logo: data['logo'],
        flag: data['flag'],
        season: data['season'],
        round: data['round'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        logo,
        flag,
        season,
        round,
      ];
}

class TeamsDTO extends Equatable {
  final TeamDTO home;
  final TeamDTO away;

  const TeamsDTO(this.home, this.away);

  factory TeamsDTO.fromJson(Map<String, dynamic> data) => TeamsDTO(
        TeamDTO.fromJson(data['home']),
        TeamDTO.fromJson(data['away']),
      );

  @override
  List<Object?> get props => [home, away];
}

class TeamDTO extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool? winner;

  const TeamDTO({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
  });

  factory TeamDTO.fromJson(Map<String, dynamic> data) => TeamDTO(
        id: data['id'],
        name: data['name'],
        logo: data['logo'],
        winner: data['winner'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        logo,
        winner,
      ];
}

class GoalsDTO extends Equatable {
  final int? home;
  final int? away;

  const GoalsDTO(this.home, this.away);

  factory GoalsDTO.fromJson(Map<String, dynamic> data) => GoalsDTO(
        data['home'],
        data['away'],
      );

  @override
  List<Object?> get props => [home, away];
}

class ScoresDTO extends Equatable {
  final GoalsDTO halftime;
  final GoalsDTO fulltime;
  final GoalsDTO extratime;
  final GoalsDTO penalty;

  const ScoresDTO({
    required this.halftime,
    required this.fulltime,
    required this.extratime,
    required this.penalty,
  });

  factory ScoresDTO.fromJson(Map<String, dynamic> data) => ScoresDTO(
        halftime: GoalsDTO.fromJson(data['halftime']),
        fulltime: GoalsDTO.fromJson(data['fulltime']),
        extratime: GoalsDTO.fromJson(data['extratime']),
        penalty: GoalsDTO.fromJson(data['penalty']),
      );

  @override
  List<Object?> get props => [
        halftime,
        fulltime,
        extratime,
        penalty,
      ];
}

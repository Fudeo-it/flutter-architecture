import 'package:matches/models/match.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MatchWidget extends StatelessWidget {
  final Match match;

  const MatchWidget(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ChampionshipAndStadiumWidget(match),
              MatchContentWidget(match),
            ],
          ),
        ),
      );
}

class ChampionshipAndStadiumWidget extends StatelessWidget {
  final Match match;

  const ChampionshipAndStadiumWidget(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Image.network(
                  match.league.imageUrl,
                  width: 24,
                  height: 24,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '${match.league.name}: ${match.league.round} - ${match.stadium}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (match.live)
            const Padding(
              padding: EdgeInsets.only(left: 8, top: 3),
              child: Icon(
                Icons.rss_feed,
                color: Colors.red,
                size: 17,
              ),
            ),
        ],
      );
}

class MatchContentWidget extends StatelessWidget {
  final Match match;

  const MatchContentWidget(this.match, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TeamAndScore(
                      match.teams.home,
                      live: match.live,
                      finished: match.finished,
                    ),
                    TeamAndScore(
                      match.teams.away,
                      live: match.live,
                      finished: match.finished,
                    ),
                  ],
                ),
              ),
              const VerticalDivider(width: 32),
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      match.live
                          ? '${match.elapsed ?? '1'}\''
                          : DateFormat.Hm().format(match.dateTime),
                      style: TextStyle(color: match.live ? Colors.red : null),
                    ),
                    if (match.live && match.status != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          match.status!.name.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class TeamAndScore extends StatelessWidget {
  final Team team;
  final bool live;
  final bool finished;

  const TeamAndScore(
    this.team, {
    Key? key,
    this.live = false,
    this.finished = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Image.network(
              team.logoUrl,
              width: 16,
              height: 16,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                team.name,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            if (finished || live)
              Expanded(
                child: Text(
                  team.goals.toString(),
                  textAlign: TextAlign.end,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(color: live ? Colors.red : null),
                ),
              ),
          ],
        ),
      );
}

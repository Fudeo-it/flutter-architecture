import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matches/blocs/matches/matches_bloc.dart';
import 'package:matches/cubits/date_selector_cubit.dart';
import 'package:matches/models/match.dart';
import 'package:matches/widgets/app_bar_title.dart';
import 'package:matches/widgets/calendar_widget.dart';
import 'package:matches/widgets/courtesy_widget.dart';
import 'package:matches/widgets/loading_widget.dart';
import 'package:matches/widgets/match_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../repositories/matches_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 1,
    );

    _itemPositionsListener.itemPositions.addListener(_onItemPositionsChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _itemPositionsListener.itemPositions
        .removeListener(_onItemPositionsChanged);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => MatchesBloc(
          matchesRepository: context.read<MatchesRepository>(),
        )..fetchMatches(DateTime.now()),
        child: Scaffold(
          appBar: AppBar(
            title: const AppBarTitle(),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (position) => _itemScrollController.scrollTo(
                index: position,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeIn,
              ),
              tabs: const [
                Tab(text: 'Calendario'),
                Tab(text: 'Oggi'),
              ],
            ),
          ),
          body: _body(context),
        ),
      );

  Widget _body(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final items = [
      BlocBuilder<DateSelectorCubit, DateTime>(
        builder: (context, selectedDate) => CalendarWidget(
          selectedDate,
          onDaySelected: (date, _) {
            context.read<DateSelectorCubit>().select(date);
            context.read<MatchesBloc>().fetchMatches(date);
          },
        ),
      ),
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.width,
          minHeight: size.height,
        ),
        child:
            BlocBuilder<MatchesBloc, MatchesState>(builder: (context, state) {
          if (state is FetchedMatchesState) {
            return _listWidget(
              context,
              matches: state.matches,
            );
          } else if (state is ErrorMatchesState) {
            return Center(
              child: CourtesyWidget(
                title: 'Uh oh!',
                subtitle: state.errorMessage ?? 'Generic error',
              ),
            );
          } else if (state is NoMatchesState) {
            return const Center(
              child: CourtesyWidget(
                title: 'Ops',
                subtitle: 'No match available',
              ),
            );
          }

          return const LoadingWidget();
        }),
      ),
    ];

    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemPositionsListener: _itemPositionsListener,
      itemBuilder: (_, index) => items[index],
      itemCount: items.length,
      initialScrollIndex: 1,
    );
  }

  Widget _listWidget(
    BuildContext context, {
    List<Match> matches = const [],
  }) =>
      ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 4.0,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => MatchWidget(matches[index]),
        itemCount: matches.length,
      );

  void _onItemPositionsChanged() {
    final position = _itemPositionsListener.itemPositions.value.first.index;

    setState(() {
      _tabController.animateTo(position);
    });
  }
}

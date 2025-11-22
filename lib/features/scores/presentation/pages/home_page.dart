import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/core/di/scores_injection.dart' as di;

import '../bloc/score_bloc.dart';
import '../widgets/score_card.dart';
import 'score_detail_page.dart';

class HomePage extends StatefulWidget {
  final void Function(ThemeMode) onChangeTheme;
  final void Function(Locale) onChangeLocale;
  const HomePage(
      {Key? key, required this.onChangeTheme, required this.onChangeLocale})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScoreBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = di.sl<ScoreBloc>();
    // Preload all
    bloc.add(LoadScoresEvent());
  }

  @override
  Widget build(BuildContext context) {
    final nowStr =
        DateFormat.yMd(Localizations.localeOf(context).toLanguageTag())
            .format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text('Scores'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'en') widget.onChangeLocale(const Locale('en'));
              if (v == 'hr') widget.onChangeLocale(const Locale('hr'));
              if (v == 'light') widget.onChangeTheme(ThemeMode.light);
              if (v == 'dark') widget.onChangeTheme(ThemeMode.dark);
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'hr', child: Text('Croatian')),
              const PopupMenuItem(value: 'light', child: Text('Light')),
              const PopupMenuItem(value: 'dark', child: Text('Dark')),
            ],
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          bloc.add(LoadScoresEvent()); // reload
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BlocBuilder<ScoreBloc, ScoreState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ScoreLoading || state is ScoreInitial) {
                    return Column(
                      children: List.generate(
                          3,
                          (i) => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: SizedBox(
                                    height: 72,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              )),
                    );
                  } else if (state is ScoreLoaded) {
                    // for demo create three cards with latest values per type
                    final list = state.records;
                    // get latest by type
                    int getLatestScore(String type) {
                      final found = list
                          .where((r) =>
                              r.type?.toLowerCase() == type.toLowerCase())
                          .toList();
                      if (found.isEmpty) return 0;
                      return found.first.score ?? 0;
                    }

                    return Column(
                      children: [
                        ScoreCard(
                          title: 'Activity',
                          value: getLatestScore('activity'),
                          type: 'activity',
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ScoreDetailPage(type: 'activity'))),
                        ),
                        const SizedBox(height: 12),
                        ScoreCard(
                          title: 'Readiness',
                          value: getLatestScore('readiness'),
                          type: 'readiness',
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ScoreDetailPage(type: 'readiness'))),
                        ),
                        const SizedBox(height: 12),
                        ScoreCard(
                          title: 'Health',
                          value: getLatestScore('health'),
                          type: 'health',
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ScoreDetailPage(type: 'health'))),
                        ),
                      ],
                    );
                  } else if (state is ScoreError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 24),
              Text('Updated: $nowStr',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

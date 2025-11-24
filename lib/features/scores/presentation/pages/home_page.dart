import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/core/assets/app_icon_paths.dart';
import 'package:rolla_demo_app/core/di/scores_injection.dart' as di;
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon_button.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/settings/presentation/pages/settings_page.dart';

import '../bloc/score_bloc.dart';
import '../widgets/score_card.dart';
import 'score_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScoreBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = di.sl<ScoreBloc>();
    _loadLatestScore();
  }

  void _loadLatestScore() async {
    bloc.add(LoadScoresEvent());
  }

  @override
  Widget build(BuildContext context) {
    final nowStr = DateFormat.yMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text('Scores'),
        actions: [
          AppIconButton.asset(
            AppIconPaths.settings,
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadLatestScore();
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
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      ),
                    );
                  } else if (state is ScoreLoaded) {
                    Score? latestScore = state.scores.firstOrNull;

                    return Column(
                      children: [
                        ScoreCard(
                          icon: AppIcon(
                            AppIconPaths.fire,
                            color: AppColors.green,
                          ),
                          title: tr.activity,
                          value: latestScore?.activityScore.toDouble(),
                          scoreValue: latestScore?.activityScore.toDouble(),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ScoreDetailPage(type: 'activity'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ScoreCard(
                          icon: AppIcon(
                            AppIconPaths.moon,
                            color: AppColors.purple,
                          ),
                          title: tr.readiness,
                          value: latestScore?.readinessScore.toDouble(),
                          scoreValue: latestScore?.readinessScore.toDouble(),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ScoreDetailPage(type: 'readiness'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        ScoreCard(
                          icon: AppIcon(
                            AppIconPaths.heartRate,
                            color: AppColors.lightBlue,
                          ),
                          title: tr.health,
                          value: latestScore?.healthScore.toDouble(),
                          scoreValue: latestScore?.healthScore.toDouble(),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ScoreDetailPage(type: 'health'),
                            ),
                          ),
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
              Text(
                'Updated: $nowStr',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

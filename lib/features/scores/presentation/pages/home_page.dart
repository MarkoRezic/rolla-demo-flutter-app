import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rolla_demo_app/core/assets/app_icon_paths.dart';
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/core/presentation/bloc/settings_cubit.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon.dart';
import 'package:rolla_demo_app/core/presentation/widgets/app_icon_button.dart';
import 'package:rolla_demo_app/core/theme/app_colors.dart';
import 'package:rolla_demo_app/core/utils/date_time_utils.dart';
import 'package:rolla_demo_app/features/scores/domain/entities/score.dart';
import 'package:rolla_demo_app/features/scores/presentation/bloc/score_bloc.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';
import 'package:rolla_demo_app/features/scores/presentation/widgets/data_visualization/score_card.dart';
import 'package:rolla_demo_app/features/settings/presentation/pages/settings_page.dart';

import 'score_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScoreBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = GetIt.instance<ScoreBloc>();
    _loadCurrentDateScore(mockLoadingTime: const Duration(milliseconds: 2500));
  }

  void _loadCurrentDateScore({Duration? mockLoadingTime}) async {
    bloc.add(
      LoadScoresEvent(
        from: startOfCurrentDay(),
        to: endOfCurrentDay(),
        mockLoadingTime: mockLoadingTime ?? const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(tr.homeTitle),
        actions: <Widget>[
          AppIconButton.asset(
            AppIconPaths.settings,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadCurrentDateScore();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Column(
            children: <Widget>[
              BlocBuilder<SettingsCubit, SettingsState>(
                builder: (BuildContext context, SettingsState state) {
                  if (state is! SettingsLoaded) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: <Widget>[
                      Text(
                        tr.welcomeName(state.settings.name),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        tr.theseAreYourScoresForToday,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
              BlocBuilder<ScoreBloc, ScoreState>(
                bloc: bloc,
                builder: (BuildContext context, ScoreState state) {
                  if (state is ScoreLoading || state is ScoreInitial) {
                    return Column(
                      children: List<Widget>.generate(
                        3,
                        (int i) => Padding(
                          padding: EdgeInsets.only(bottom: i == 2 ? 0 : 20),
                          child: const ScoreCard.loading(),
                        ),
                      ),
                    );
                  } else if (state is ScoreLoaded) {
                    final Score? todayScore = state.scores.firstOrNull;

                    return Column(
                      children: <Widget>[
                        ScoreCard(
                          icon: AppIcon(
                            AppIconPaths.heartRate,
                            color: AppColors.lightBlue,
                          ),
                          title: tr.health,
                          value: todayScore?.healthScore.toDouble(),
                          scoreValue: todayScore?.healthScore.toDouble(),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ScoreDetailPage(
                                scoreType: ScoreType.health,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ScoreCard(
                          icon: AppIcon(
                            AppIconPaths.moon,
                            color: AppColors.purple,
                          ),
                          title: tr.readiness,
                          value: todayScore?.readinessScore.toDouble(),
                          scoreValue: todayScore?.readinessScore.toDouble(),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ScoreDetailPage(
                                scoreType: ScoreType.readiness,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ScoreCard(
                          icon: AppIcon(
                            AppIconPaths.fire,
                            color: AppColors.green,
                          ),
                          title: tr.activity,
                          value: todayScore?.activityScore.toDouble(),
                          scoreValue: todayScore?.activityScore.toDouble(),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const ScoreDetailPage(
                                scoreType: ScoreType.activity,
                              ),
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
              const SizedBox(height: 36),
              Text(
                tr.tapOnAScoreToSeeItsDetails,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

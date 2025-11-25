import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rolla_demo_app/core/di/scores_injection.dart' as di;
import 'package:rolla_demo_app/core/localization/tr.dart';
import 'package:rolla_demo_app/features/scores/presentation/enums/score_type.dart';

import '../bloc/score_bloc.dart';

class ScoreDetailPage extends StatefulWidget {
  final ScoreType scoreType;
  const ScoreDetailPage({Key? key, required this.scoreType}) : super(key: key);

  @override
  State<ScoreDetailPage> createState() => _ScoreDetailPageState();
}

class _ScoreDetailPageState extends State<ScoreDetailPage> {
  late ScoreBloc bloc;
  String timeframe = '1D';

  @override
  void initState() {
    super.initState();
    bloc = di.sl<ScoreBloc>();
    _load();
  }

  void _load() {
    final now = DateTime.now().toUtc();
    DateTime from;
    if (timeframe == '1D') {
      from = now.subtract(const Duration(days: 1));
    } else if (timeframe == '7D') {
      from = now.subtract(const Duration(days: 7));
    } else if (timeframe == '30D') {
      from = now.subtract(const Duration(days: 30));
    } else {
      from = now.subtract(const Duration(days: 365));
    }
    bloc.add(LoadScoresEvent(from: from, to: now));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.scoreType.scoreTitle)),
      body: RefreshIndicator(
        onRefresh: () async => _load(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // timeframe selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['1D', '7D', '30D', '1Y'].map((tf) {
                  final selected = tf == timeframe;
                  return ChoiceChip(
                    label: Text(tf),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => timeframe = tf);
                      _load();
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              BlocBuilder<ScoreBloc, ScoreState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ScoreLoading || state is ScoreInitial) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is ScoreLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          tr.about,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.scoreType.scoreDescription,
                          style: Theme.of(context).textTheme.bodyMedium,
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
            ],
          ),
        ),
      ),
    );
  }
}

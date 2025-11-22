import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rolla_demo_app/core/di/scores_injection.dart' as di;
import 'package:rolla_demo_app/core/utils/pdf_exporter.dart';

import '../../data/repositories/score_repository_impl.dart';
import '../bloc/score_bloc.dart';
import '../widgets/radial_gauge.dart';
import '../widgets/score_card.dart';
import '../widgets/trend_chart.dart';

class ScoreDetailPage extends StatefulWidget {
  final String type;
  const ScoreDetailPage({Key? key, required this.type}) : super(key: key);

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
    bloc.add(LoadScoresEvent(type: widget.type, from: from, to: now));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              await PdfExporter.exportScoreDetailPdf(context, widget.type);
            },
          )
        ],
      ),
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
                        child: Center(child: CircularProgressIndicator()));
                  } else if (state is ScoreLoaded) {
                    final records = state.records
                        .where((r) => r.type == widget.type)
                        .toList();
                    if (records.isEmpty) {
                      return Center(child: Text('No data'));
                    }
                    final latest = records.first;
                    final value = latest.score ?? 0;

                    // build spots for chart (dummy mapping by timestamp order)
                    final spots = <FlSpot>[];
                    for (var i = 0; i < records.length; i++) {
                      spots.add(FlSpot(
                          i.toDouble(), (records[i].score ?? 0).toDouble()));
                    }

                    return Column(
                      children: [
                        ScoreCard(
                            title: widget.type,
                            value: value,
                            type: widget.type),
                        const SizedBox(height: 12),
                        RadialGauge(value: value, type: widget.type),
                        const SizedBox(height: 12),
                        TrendChart(spots: spots, type: widget.type),
                        const SizedBox(height: 12),
                        // metrics - show first record metrics
                        if (latest.metrics != null &&
                            (latest.metrics as Map).isNotEmpty)
                          ...((latest.metrics as Map<String, dynamic>)
                              .entries
                              .map((e) {
                            final k = e.key;
                            final v = e.value;
                            return ListTile(
                              title: Text(k),
                              trailing: Text('$v'),
                            );
                          }).toList())
                        else
                          const Text('No metric data'),
                      ],
                    );
                  } else if (state is ScoreError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

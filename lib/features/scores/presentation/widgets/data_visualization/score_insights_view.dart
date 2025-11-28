import 'dart:async';

import 'package:flutter/material.dart';

class ScoreInsightsView extends StatefulWidget {
  const ScoreInsightsView({
    super.key,
    required this.items,
    required this.color,
    this.displayDuration = const Duration(seconds: 5),
    this.transitionDuration = const Duration(milliseconds: 600),
    this.textStyle,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.constraints,
  });
  final List<String> items;
  final Color color;
  final Duration displayDuration;
  final Duration transitionDuration;
  final TextStyle? textStyle;
  final double borderRadius;
  final EdgeInsets padding;
  final BoxConstraints? constraints;

  @override
  State<ScoreInsightsView> createState() => _ScoreInsightsViewState();
}

class _ScoreInsightsViewState extends State<ScoreInsightsView> {
  int _index = 0;
  double _opacity = 0.0;
  bool _running = true;
  // used to cancel the async loop on dispose
  late final Completer<void> _cancelCompleter;

  @override
  void initState() {
    super.initState();
    _cancelCompleter = Completer<void>();
    // Start with opacity 0 and fade in after first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() => _opacity = 1.0);
      _startLoop();
    });
  }

  @override
  void didUpdateWidget(covariant ScoreInsightsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If items changed and current index is out of bounds, clamp it.
    if (_index >= widget.items.length && widget.items.isNotEmpty) {
      setState(() => _index = 0);
    }
    // if items became empty - fade out
    if (widget.items.isEmpty && _opacity != 0.0) {
      setState(() => _opacity = 0.0);
    }
    // if items were added and currently hidden, ensure it fades in
    if (widget.items.isNotEmpty && _opacity == 0.0) {
      setState(() => _opacity = 1.0);
    }
  }

  Future<void> _startLoop() async {
    // Single item -> no swapping, just keep it visible (but initial fade was done).
    if (widget.items.length <= 1) return;

    while (mounted && _running) {
      // wait for the display duration
      final Future<dynamic> wait = Future.delayed(widget.displayDuration);
      // allow cancellation
      await Future.any(<Future<void>>[wait, _cancelCompleter.future]);
      if (!mounted || _cancelCompleter.isCompleted) break;

      // fade out
      setState(() => _opacity = 0.0);
      final Future<dynamic> fadeOut = Future.delayed(widget.transitionDuration);
      await Future.any(<Future<void>>[fadeOut, _cancelCompleter.future]);
      if (!mounted || _cancelCompleter.isCompleted) break;

      // swap index to next
      setState(() => _index = (_index + 1) % widget.items.length);

      // fade in
      setState(() => _opacity = 1.0);
      final Future<dynamic> fadeIn = Future.delayed(widget.transitionDuration);
      await Future.any(<Future<void>>[fadeIn, _cancelCompleter.future]);
      if (!mounted || _cancelCompleter.isCompleted) break;
    }
  }

  @override
  void dispose() {
    _running = false;
    if (!_cancelCompleter.isCompleted) _cancelCompleter.complete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasContent = widget.items.isNotEmpty;
    final TextStyle? effectiveTextStyle =
        widget.textStyle ?? Theme.of(context).textTheme.bodyLarge;

    // Soft shadow using the same color as container, with low opacity.
    final List<BoxShadow> boxShadow = <BoxShadow>[
      BoxShadow(
        color: widget.color.withValues(alpha: 0.8),
        blurRadius: 35,
        spreadRadius: 6,
      ),
    ];

    return AnimatedOpacity(
      duration: widget.transitionDuration,
      curve: Curves.easeInOut,
      opacity: hasContent ? 1.0 : 0.0,
      child: ConstrainedBox(
        constraints: widget.constraints ?? const BoxConstraints(minHeight: 56),
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                widget.color.withValues(alpha: 0.8),
                widget.color.withValues(alpha: 0.0),
              ],
              stops: const <double>[0.5, 1],
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: boxShadow,
          ),
          child: Center(
            child: AnimatedOpacity(
              // controls the text fade-in / fade-out
              duration: widget.transitionDuration,
              curve: Curves.easeInOut,
              opacity: hasContent ? _opacity : 0.0,
              child: Text(
                hasContent ? widget.items[_index] : '',
                textAlign: TextAlign.center,
                style: effectiveTextStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

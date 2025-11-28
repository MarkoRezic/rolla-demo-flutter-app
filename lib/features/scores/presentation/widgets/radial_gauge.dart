import 'package:flutter/material.dart';
import 'package:rolla_demo_app/core/theme/app_theme.dart';

class RadialGauge extends StatefulWidget {
  final int value;
  final Color? valueColor;
  final Color? trackColor;
  final Color? backgroundColor;
  final double outerRadius;
  final double innerRadius;
  final double trackWidth;
  final double fontSize;

  const RadialGauge({
    Key? key,
    required this.value,
    this.valueColor,
    this.trackColor,
    this.backgroundColor,
    this.outerRadius = 128,
    this.innerRadius = 96,
    this.trackWidth = 6,
    this.fontSize = 32,
  }) : super(key: key);

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge>
    with TickerProviderStateMixin {
  // Entry animation (scale + fade)
  late final AnimationController _entryController;
  late final Animation<double> _entryScale;
  late final Animation<double> _entryOpacity;

  // Value animation (number + progress)
  late AnimationController _valueController;
  late Tween<double> _valueTween;
  late Animation<double> _valueAnimation;

  int _previousValue = 0;

  @override
  void initState() {
    super.initState();

    // Clamp incoming value into 0..100
    _previousValue = 0;

    // Entry animation
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _entryScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );
    _entryOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );

    // Value animation controller (reused when value changes)
    _valueController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // initial tween: 0 -> initial value
    _valueTween = Tween<double>(
      begin: _previousValue.toDouble(),
      end: widget.value.toDouble(),
    );
    _valueAnimation = _valueTween.animate(
      CurvedAnimation(parent: _valueController, curve: Curves.easeOut),
    );

    // start both
    _entryController.forward();
    _valueController.forward();
  }

  @override
  void didUpdateWidget(covariant RadialGauge oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If value changed, animate from old -> new
    if (oldWidget.value != widget.value) {
      _previousValue = oldWidget.value.clamp(0, 100);
      _valueTween = Tween<double>(
        begin: _previousValue.toDouble(),
        end: widget.value.clamp(0, 100).toDouble(),
      );
      _valueAnimation = _valueTween.animate(
        CurvedAnimation(parent: _valueController, curve: Curves.easeOut),
      );
      _valueController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double outer = widget.outerRadius;
    final double inner = widget.innerRadius;
    final trackWidth = widget.trackWidth;

    return FadeTransition(
      opacity: _entryOpacity,
      child: ScaleTransition(
        scale: _entryScale,
        child: SizedBox(
          height: outer,
          width: outer,
          child: AnimatedBuilder(
            animation: _valueAnimation,
            builder: (context, child) {
              final animatedValue = (_valueAnimation.value).clamp(0.0, 100.0);
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color:
                      widget.backgroundColor ??
                      Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.lightGrey(context),
                      spreadRadius: 8,
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: inner,
                      width: inner,
                      child: CircularProgressIndicator(
                        value: animatedValue / 100.0,
                        strokeWidth: trackWidth,
                        strokeCap: StrokeCap.round,
                        color:
                            widget.valueColor ?? Theme.of(context).primaryColor,
                        backgroundColor:
                            widget.trackColor ?? AppTheme.lightGrey(context),
                      ),
                    ),
                    Text(
                      '${animatedValue.round()}',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

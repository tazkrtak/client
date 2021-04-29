import 'dart:ui';

import 'package:flutter/material.dart';

class RRectProgressIndicator extends ImplicitlyAnimatedWidget {
  final double size;
  final double stroke;
  final double borderRadius;
  final double value;

  const RRectProgressIndicator({
    this.size = 200,
    this.stroke = 8,
    this.borderRadius = 16,
    Duration duration = const Duration(seconds: 1),
    required this.value,
  }) : super(
          duration: duration,
          curve: Curves.linear,
        );

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedPaddingState();
}

class _AnimatedPaddingState
    extends AnimatedWidgetBaseState<RRectProgressIndicator> {
  Tween<double>? _value;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _value = visitor(_value, widget.value,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      foregroundPainter: _RRectProgressIndicatorPainter(
        stroke: widget.stroke,
        value: _value!.evaluate(animation).clamp(0, 1),
        borderRadius: widget.borderRadius,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _RRectProgressIndicatorPainter extends CustomPainter {
  final double stroke;
  final Color color;
  final double value;
  final double borderRadius;

  _RRectProgressIndicatorPainter({
    required this.stroke,
    required this.color,
    required this.value,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rectangle = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );

    final roundedRectangle = RRect.fromRectAndRadius(
      rectangle,
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(roundedRectangle);
    final pathPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, pathPaint);

    final percentPath = Path();
    final percentPaint = Paint()
      ..color = color
      ..strokeWidth = stroke + 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final PathMetric pathMetric in path.computeMetrics()) {
      percentPath.addPath(
        pathMetric.extractPath(0, pathMetric.length * value),
        Offset.zero,
      );
    }

    canvas.drawPath(percentPath, percentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

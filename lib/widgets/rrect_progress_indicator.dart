import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RRectProgressIndicator extends StatelessWidget {
  final double? size;
  final double? stroke;

  final double value;

  const RRectProgressIndicator({
    Key? key,
    this.size = 200,
    this.stroke = 10,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size!, size!),
      foregroundPainter: _RRectProgressIndicatorPainter(
        stroke: stroke!,
        value: value,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class _RRectProgressIndicatorPainter extends CustomPainter {
  final double stroke;
  final Color color;
  final double value;

  _RRectProgressIndicatorPainter({
    required this.stroke,
    required this.color,
    required this.value,
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
      const Radius.circular(10),
    );

    final path = Path()..addRRect(roundedRectangle);
    final pathPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = stroke
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, pathPaint);

    final percentPath = _createAnimatedPath(path, value);
    final percentagePaint = Paint()
      ..color = color
      ..strokeWidth = stroke + 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(percentPath, percentagePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Path _createAnimatedPath(Path originalPath, double animationPercent) {
    final totalLength = originalPath.computeMetrics().fold(
          0.0,
          (double prev, PathMetric metric) => prev + metric.length,
        );

    final currentLength = totalLength * animationPercent;

    return _extractPathUntilLength(originalPath, currentLength);
  }

  Path _extractPathUntilLength(Path originalPath, double length) {
    var currentLength = 0.0;

    final path = Path();

    final metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      final metric = metricsIterator.current;

      final nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);
        path.addPath(pathSegment, Offset.zero);
        break;
      } else {
        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

import '../../../l10n/tr.dart';

enum RangeType {
  oneWeek,
  oneMonth,
  threeMonth,
}

class DateRangePicker extends StatelessWidget {
  final void Function(DateTime) onChange;
  static final DateTime _now = DateTime.now();

  static final Map<String, DateTime> ranges = {
    '${RangeType.oneWeek}': DateTime(
      _now.year,
      _now.month,
      _now.day - _now.weekday,
    ),
    '${RangeType.oneMonth}': DateTime(
      _now.year,
      _now.month - 1,
      _now.day,
    ),
    '${RangeType.threeMonth}': DateTime(
      _now.year,
      _now.month - 3,
      _now.day,
    )
  };

  const DateRangePicker({required this.onChange});

  @override
  Widget build(BuildContext context) {
    final controller = AdvancedSegmentController('${RangeType.oneWeek}');

    controller.addListener(() {
      onChange(ranges[controller.value]!);
    });

    return Center(
      child: AdvancedSegment(
        controller: controller,
        segments: {
          '${RangeType.oneWeek}': tr(context).tabBar_oneWeek,
          '${RangeType.oneMonth}': tr(context).tabBar_oneMonth,
          '${RangeType.threeMonth}': tr(context).tabBar_ThreeMonth,
        },
        inactiveStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 16,
        ),
        activeStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(16),
        shadow: null,
        itemPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        sliderOffset: 6,
      ),
    );
  }
}

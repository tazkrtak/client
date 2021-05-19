import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import '../../../l10n/tr.dart';

class HorizontalPicker extends StatelessWidget {
  final void Function(DateTime) onChange;

  const HorizontalPicker({required this.onChange});

  @override
  Widget build(BuildContext context) {
    final selectedSegment = AdvancedSegmentController('one-week');

    selectedSegment.addListener(() {
      onChange(_mapRangeToDate(selectedSegment.value));
    });

    return Center(
      child: AdvancedSegment(
        controller: selectedSegment,
        segments: {
          'one-week': tr(context).tabBar_oneWeek.toString(),
          'one-month': tr(context).tabBar_oneMonth.toString(),
          'three-month': tr(context).tabBar_ThreeMonth.toString(),
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
        sliderColor: Theme.of(context).backgroundColor,
        shadow: const [
          BoxShadow(
            color: Colors.transparent,
          ),
        ],
        itemPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        sliderOffset: 6,
      ),
    );
  }
}

DateTime _mapRangeToDate(String type) {
  final now = DateTime.now();

  switch (type) {
    case 'one-week':
      // Start from sunday
      final today = now.weekday;
      return DateTime(now.year, now.month, now.day - today);
    case 'one-month':
      return DateTime(now.year, now.month - 1, now.day);
    case 'three-month':
      return DateTime(now.year, now.month - 3, now.day);
    default:
      throw ArgumentError('type not supported');
  }
}

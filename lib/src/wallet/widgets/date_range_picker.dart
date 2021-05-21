import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/tr.dart';
import '../cubits/date_range_cubit.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker();

  @override
  Widget build(BuildContext context) {
    final controller = AdvancedSegmentController('${DateRange.oneWeek}');

    controller.addListener(() {
      final key = controller.value;
      final range = DateRange.values.firstWhere((r) => '$r' == key);
      context.read<DateRangeCubit>().updateRange(range);
    });

    return Center(
      child: AdvancedSegment(
        controller: controller,
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
        segments: {
          '${DateRange.oneWeek}': tr(context).tabBar_oneWeek,
          '${DateRange.oneMonth}': tr(context).tabBar_oneMonth,
          '${DateRange.threeMonth}': tr(context).tabBar_ThreeMonth,
        },
      ),
    );
  }
}

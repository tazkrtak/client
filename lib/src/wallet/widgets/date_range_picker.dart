import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/tr.dart';
import '../cubits/date_range_cubit.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker();

  @override
  Widget build(BuildContext context) {
    final controller = AdvancedSegmentController(
      '${DateRangeCubit.initialState}',
    );

    controller.addListener(() {
      final key = controller.value;
      final range = DateRange.values.firstWhere((r) => '$r' == key);
      context.read<DateRangeCubit>().updateRange(range);
    });

    return Center(
      child: AdvancedSegment(
        controller: controller,
        backgroundColor: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(16),
        shadow: null,
        sliderOffset: 6,
        itemPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        inactiveStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 16,
        ),
        activeStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        segments: {
          '${DateRange.oneWeek}': tr(context).wallet_oneWeek,
          '${DateRange.oneMonth}': tr(context).wallet_oneMonth,
          '${DateRange.threeMonth}': tr(context).wallet_ThreeMonth,
        },
      ),
    );
  }
}

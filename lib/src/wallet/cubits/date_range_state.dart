part of 'date_range_cubit.dart';

enum DateRange {
  oneWeek,
  oneMonth,
  threeMonth,
}

extension DateRangeExtensions on DateRange {
  DateTime get date {
    final DateTime now = DateTime.now();
    switch (this) {
      case DateRange.oneWeek:
        return DateTime(
          now.year,
          now.month,
          now.day - 7,
        );
      case DateRange.oneMonth:
        return DateTime(
          now.year,
          now.month - 1,
          now.day,
        );
      case DateRange.threeMonth:
        return DateTime(
          now.year,
          now.month - 3,
          now.day,
        );
    }
  }

  DateFilter get dateFilter => DateFilter(date);
}

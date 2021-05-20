part of 'date_range_cubit.dart';

enum DateRange {
  oneWeek,
  oneMonth,
  threeMonth,
}

class DateRangeState extends Equatable {
  final DateRange range;

  const DateRangeState(this.range);

  DateFilter toDateFilter() => DateFilter(_getDate());

  DateTime _getDate() {
    final DateTime now = DateTime.now();

    switch (range) {
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

  @override
  List<Object?> get props => [range];
}

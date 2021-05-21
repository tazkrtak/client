import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../api/api.dart';

part 'date_range_state.dart';

class DateRangeCubit extends Cubit<DateRangeState> {
  DateRangeCubit() : super(const DateRangeState(DateRange.oneWeek));

  void updateRange(DateRange range) {
    emit(DateRangeState(range));
  }
}

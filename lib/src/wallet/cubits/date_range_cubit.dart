import 'package:bloc/bloc.dart';

import '../../../api/api.dart';

part 'date_range_state.dart';

class DateRangeCubit extends Cubit<DateRange> {
  static DateRange get initialState => DateRange.oneWeek;

  DateRangeCubit() : super(initialState);

  void updateRange(DateRange range) {
    emit(range);
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

class DateSelectorCubit extends Cubit<DateTime> {
  DateSelectorCubit() : super(DateTime.now());

  void select(DateTime date) => emit(date);
}

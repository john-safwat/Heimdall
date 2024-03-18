import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseNavigator.dart';
import 'package:time_range_picker/time_range_picker.dart';

abstract class CreateKeyNavigator extends BaseNavigator {

  Future<DateTime> showDatePiker(DateTime selectedDate);
  Future<DateTimeRange> showRangeDatePiker(DateTimeRange selectedDate);
  Future<TimeRange> showRangeTimePiker(TimeRange  selectedTime);

}
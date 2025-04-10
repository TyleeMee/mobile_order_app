import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_formatter.g.dart';

@riverpod
String dateWithYear(Ref ref, DateTime date) {
  return DateFormat('yyyy年MM月dd日').format(date);
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_formatter.g.dart';

@riverpod
NumberFormat currencyFormatter(Ref ref) {
  /// Currency formatter to be used in the app.
  return NumberFormat.currency(name: 'JPY', symbol: '¥');
}

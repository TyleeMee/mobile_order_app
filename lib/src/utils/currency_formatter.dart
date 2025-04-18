import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'currency_formatter.g.dart';

@riverpod
NumberFormat currencyFormatter(Ref ref) {
  /// アプリ内で使用する通貨フォーマッター
  return NumberFormat.currency(name: 'JPY', symbol: '¥');
}

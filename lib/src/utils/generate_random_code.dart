import 'dart:math';

String generateRandomCode() {
  final random = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

  return String.fromCharCodes(
    Iterable.generate(4, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

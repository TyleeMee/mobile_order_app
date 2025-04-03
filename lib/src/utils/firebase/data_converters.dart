/// Firestoreの変換処理に関するユーティリティクラス
class FirestoreConverters {
  /// Map<String, dynamic>から特定のキーに対応するList<String>を抽出する
  ///
  /// [data] - Firestoreから取得したデータ
  /// [key] - 抽出したいリストのキー
  /// [defaultValue] - データが存在しない場合のデフォルト値（省略可）
  static List<String> toStringList(
    Map<String, dynamic>? data,
    String key, {
    List<String> defaultValue = const [],
  }) {
    if (data == null || !data.containsKey(key)) return defaultValue;

    final value = data[key];
    if (value == null) return defaultValue;

    //* Firestoreの List 型は実際には List<dynamic> として扱われるため、明示的な型変換が必要
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    }

    //TODO　不要であれば削除
    // デバッグモードでは型の不一致を警告
    // if (kDebugMode) {
    //   print('Warning: Expected List for key "$key", but got ${value.runtimeType}');
    // }

    return defaultValue;
  }
}

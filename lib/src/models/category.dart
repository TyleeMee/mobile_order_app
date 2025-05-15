typedef CategoryID = String;

class Category {
  Category({
    required this.id,
    required this.title,
    required this.created,
    required this.updated,
  });
  final CategoryID id;
  final String title;
  final DateTime created;
  final DateTime updated;

  Category copyWith({
    CategoryID? id,
    String? title,
    DateTime? created,
    DateTime? updated,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'created': created.millisecondsSinceEpoch});
    result.addAll({'updated': updated.millisecondsSinceEpoch});

    return result;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    // タイムスタンプ変換用のヘルパー関数
    DateTime parseTimestamp(dynamic timestamp) {
      if (timestamp is int) {
        // UNIXタイムスタンプ（ミリ秒）
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      } else if (timestamp is String) {
        // ISO 8601形式の文字列
        return DateTime.parse(timestamp);
      } else {
        // 不明なフォーマットの場合は現在時刻をデフォルトとする
        return DateTime.now();
      }
    }

    return Category(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      created: parseTimestamp(map['created']),
      updated: parseTimestamp(map['updated']),
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, title: $title, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.id == id &&
        other.title == title &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ created.hashCode ^ updated.hashCode;
  }
}

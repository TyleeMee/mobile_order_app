import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  // Firestoreに保存する際のマップ
  // idはドキュメントIDとして扱われるので含めない
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'created': created.millisecondsSinceEpoch});
    result.addAll({'updated': updated.millisecondsSinceEpoch});

    return result;
  }

  //firestoreのデータをCategoryに変換
  factory Category.fromMap(String documentId, Map<String, dynamic> map) {
    final now = DateTime.now();
    // createdの変換
    DateTime created;
    if (map['created'] is Timestamp) {
      created = (map['created'] as Timestamp).toDate();
    } else if (map['created'] is int) {
      created = DateTime.fromMillisecondsSinceEpoch(map['created']);
    } else {
      created = now;
    }

    DateTime updated;
    if (map['updated'] is Timestamp) {
      updated = (map['updated'] as Timestamp).toDate();
    } else if (map['updated'] is int) {
      updated = DateTime.fromMillisecondsSinceEpoch(map['updated']);
    } else {
      updated = now;
    }

    return Category(
      id: documentId,
      title: map['title'] ?? '',
      created: created,
      updated: updated,
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

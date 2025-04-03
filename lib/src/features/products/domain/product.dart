import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';

typedef ProductID = String;

class Product {
  Product({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.imagePath,
    this.description,
    required this.price,
    required this.isVisible,
    required this.isOrderAccepting,
    required this.created,
    required this.updated,
  });
  final ProductID id;
  final CategoryID categoryId;
  final String title;
  final String imageUrl;
  final String imagePath;
  final String? description;
  final double price;
  final bool isVisible;
  final bool isOrderAccepting;
  final DateTime created;
  final DateTime updated;

  Product copyWith({
    ProductID? id,
    CategoryID? categoryId,
    String? title,
    String? imageUrl,
    String? imagePath,
    String? description,
    double? price,
    bool? isVisible,
    bool? isOrderAccepting,
    DateTime? created,
    DateTime? updated,
  }) {
    return Product(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      price: price ?? this.price,
      isVisible: isVisible ?? this.isVisible,
      isOrderAccepting: isOrderAccepting ?? this.isOrderAccepting,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.categoryId == categoryId &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.price == price &&
        other.isVisible == isVisible &&
        other.isOrderAccepting == isOrderAccepting &&
        other.created == created &&
        other.updated == updated;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'categoryId': categoryId});
    result.addAll({'title': title});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'imagePath': imagePath});
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'price': price});
    result.addAll({'isVisible': isVisible});
    result.addAll({'isOrderAccepting': isOrderAccepting});
    result.addAll({'created': created.millisecondsSinceEpoch});
    result.addAll({'updated': updated.millisecondsSinceEpoch});

    return result;
  }

  //firestoreのデータをProductに変換
  factory Product.fromMap(String documentId, Map<String, dynamic> map) {
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

    return Product(
      id: documentId,
      categoryId: map['categoryId'] as CategoryID,
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      imagePath: map['imagePath'] ?? '',
      description: map['description'],
      price: map['price']?.toDouble() ?? 0.0,
      isVisible: map['isVisible'] ?? false,
      isOrderAccepting: map['isOrderAccepting'] ?? false,
      created: created,
      updated: updated,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoryId.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        imagePath.hashCode ^
        description.hashCode ^
        price.hashCode ^
        isVisible.hashCode ^
        isOrderAccepting.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}

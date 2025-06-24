import 'dart:convert';

enum Prefecture {
  hokkaido('北海道'),
  aomori('青森県'),
  iwate('岩手県'),
  miyagi('宮城県'),
  akita('秋田県'),
  yamagata('山形県'),
  fukushima('福島県'),
  ibaraki('茨城県'),
  tochigi('栃木県'),
  gunma('群馬県'),
  saitama('埼玉県'),
  chiba('千葉県'),
  tokyo('東京都'),
  kanagawa('神奈川県'),
  niigata('新潟県'),
  toyama('富山県'),
  ishikawa('石川県'),
  fukui('福井県'),
  yamanashi('山梨県'),
  nagano('長野県'),
  gifu('岐阜県'),
  shizuoka('静岡県'),
  aichi('愛知県'),
  mie('三重県'),
  shiga('滋賀県'),
  kyoto('京都府'),
  osaka('大阪府'),
  hyogo('兵庫県'),
  nara('奈良県'),
  wakayama('和歌山県'),
  tottori('鳥取県'),
  shimane('島根県'),
  okayama('岡山県'),
  hiroshima('広島県'),
  yamaguchi('山口県'),
  tokushima('徳島県'),
  kagawa('香川県'),
  ehime('愛媛県'),
  kochi('高知県'),
  fukuoka('福岡県'),
  saga('佐賀県'),
  nagasaki('長崎県'),
  kumamoto('熊本県'),
  oita('大分県'),
  miyazaki('宮崎県'),
  kagoshima('鹿児島県'),
  okinawa('沖縄県');

  final String displayName;
  const Prefecture(this.displayName);

  static Prefecture fromDisplayName(String displayName) {
    return Prefecture.values.firstWhere(
      (p) => p.displayName == displayName,
      orElse: () => throw ArgumentError('Invalid prefecture: $displayName'),
    );
  }
}

typedef ShopID = String;

class Shop {
  Shop({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.imagePath,
    this.description,
    required this.prefecture,
    required this.city,
    required this.streetAddress,
    this.building,
    required this.isVisible,
    required this.isOrderAccepting,
    required this.created,
    required this.updated,
  });
  final ShopID id;
  final String title;
  final String imageUrl;
  final String imagePath;
  final String? description;
  final Prefecture prefecture;
  final String city;
  final String streetAddress;
  final String? building;
  final bool isVisible;
  final bool isOrderAccepting;
  final DateTime created;
  final DateTime updated;

  Shop copyWith({
    ShopID? id,
    String? title,
    String? imageUrl,
    String? imagePath,
    String? description,
    Prefecture? prefecture,
    String? city,
    String? streetAddress,
    String? building,
    bool? isVisible,
    bool? isOrderAccepting,
    DateTime? created,
    DateTime? updated,
  }) {
    return Shop(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      prefecture: prefecture ?? this.prefecture,
      city: city ?? this.city,
      streetAddress: streetAddress ?? this.streetAddress,
      building: building ?? this.building,
      isVisible: isVisible ?? this.isVisible,
      isOrderAccepting: isOrderAccepting ?? this.isOrderAccepting,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'imagePath': imagePath});
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'prefecture': prefecture});
    result.addAll({'city': city});
    result.addAll({'streetAddress': streetAddress});
    if (building != null) {
      result.addAll({'building': building});
    }
    result.addAll({'isVisible': isVisible});
    result.addAll({'isOrderAccepting': isOrderAccepting});
    result.addAll({'created': created.millisecondsSinceEpoch});
    result.addAll({'updated': updated.millisecondsSinceEpoch});

    return result;
  }

  //firestoreのデータをShopに変換
  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      imagePath: map['imagePath'] ?? '',
      description: map['description'],
      prefecture:
          map['prefecture'] is Prefecture
              ? map['prefecture']
              : (map['prefecture'] is String
                  ? Prefecture.fromDisplayName(map['prefecture'])
                  : Prefecture.tokyo),
      city: map['city'] ?? '',
      streetAddress: map['streetAddress'] ?? '',
      building: map['building'],
      isVisible: map['isVisible'] ?? false,
      isOrderAccepting: map['isOrderAccepting'] ?? false,
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      updated: DateTime.fromMillisecondsSinceEpoch(map['updated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shop.fromJson(String source) => Shop.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shop(id: $id, title: $title, imageUrl: $imageUrl, imagePath: $imagePath, description: $description, prefecture: $prefecture, city: $city, streetAddress: $streetAddress, building: $building, isVisible: $isVisible, isOrderAccepting: $isOrderAccepting, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Shop &&
        other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.imagePath == imagePath &&
        other.description == description &&
        other.prefecture == prefecture &&
        other.city == city &&
        other.streetAddress == streetAddress &&
        other.building == building &&
        other.isVisible == isVisible &&
        other.isOrderAccepting == isOrderAccepting &&
        other.created == created &&
        other.updated == updated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        imagePath.hashCode ^
        description.hashCode ^
        prefecture.hashCode ^
        city.hashCode ^
        streetAddress.hashCode ^
        building.hashCode ^
        isVisible.hashCode ^
        isOrderAccepting.hashCode ^
        created.hashCode ^
        updated.hashCode;
  }
}

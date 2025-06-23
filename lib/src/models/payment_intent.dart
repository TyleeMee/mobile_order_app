/// 決済ステータスの列挙型
enum PaymentStatus {
  pending('決済待ち'),
  processing('決済処理中'),
  completed('決済完了'),
  failed('決済失敗'),
  canceled('決済キャンセル'),
  refunded('返金済み'),
  partiallyRefunded('部分返金');

  final String displayName;
  const PaymentStatus(this.displayName);

  String toStorageString() {
    return name;
  }

  static PaymentStatus fromStorageString(String storageString) {
    return PaymentStatus.values.firstWhere(
      (s) => s.name == storageString,
      orElse:
          () =>
              throw ArgumentError(
                'Invalid payment status string: $storageString',
              ),
    );
  }
}

/// 決済Intent作成時のレスポンス型
class PaymentIntentResponse {
  final String id;
  final String clientSecret;
  final String status;
  final int amount;
  final String currency;

  PaymentIntentResponse({
    required this.id,
    required this.clientSecret,
    required this.status,
    required this.amount,
    required this.currency,
  });

  factory PaymentIntentResponse.fromMap(Map<String, dynamic> map) {
    return PaymentIntentResponse(
      id: map['id'] ?? '',
      clientSecret: map['client_secret'] ?? '',
      status: map['status'] ?? '',
      amount: map['amount']?.toInt() ?? 0,
      currency: map['currency'] ?? 'jpy',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client_secret': clientSecret,
      'status': status,
      'amount': amount,
      'currency': currency,
    };
  }
}

/// 決済メタデータの型
class PaymentMetadata {
  final double? stripeFee; // Stripe手数料
  final String? paymentMethod; // 決済方法種別
  final DateTime? processedAt; // 決済処理日時
  final String? refundReason; // 返金理由

  PaymentMetadata({
    this.stripeFee,
    this.paymentMethod,
    this.processedAt,
    this.refundReason,
  });

  factory PaymentMetadata.fromMap(Map<String, dynamic> map) {
    return PaymentMetadata(
      stripeFee: map['stripeFee']?.toDouble(),
      paymentMethod: map['paymentMethod'],
      processedAt:
          map['processedAt'] != null
              ? DateTime.parse(map['processedAt'])
              : null,
      refundReason: map['refundReason'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (stripeFee != null) 'stripeFee': stripeFee,
      if (paymentMethod != null) 'paymentMethod': paymentMethod,
      if (processedAt != null) 'processedAt': processedAt!.toIso8601String(),
      if (refundReason != null) 'refundReason': refundReason,
    };
  }
}

/// SetupIntent作成レスポンス型
class SetupIntentResponse {
  final String id;
  final String clientSecret;
  final String status;

  SetupIntentResponse({
    required this.id,
    required this.clientSecret,
    required this.status,
  });

  factory SetupIntentResponse.fromMap(Map<String, dynamic> map) {
    return SetupIntentResponse(
      id: map['id'] ?? '',
      clientSecret: map['client_secret'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'client_secret': clientSecret, 'status': status};
  }
}

/// 決済リクエスト用のカート情報
class PaymentCartInfo {
  final double total;
  final String currency;
  final int itemCount;
  final String description;

  PaymentCartInfo({
    required this.total,
    this.currency = 'jpy',
    required this.itemCount,
    required this.description,
  });

  factory PaymentCartInfo.fromMap(Map<String, dynamic> map) {
    return PaymentCartInfo(
      total: map['total']?.toDouble() ?? 0.0,
      currency: map['currency'] ?? 'jpy',
      itemCount: map['itemCount']?.toInt() ?? 0,
      description: map['description'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'currency': currency,
      'itemCount': itemCount,
      'description': description,
    };
  }
}

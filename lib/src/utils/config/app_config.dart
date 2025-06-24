/// アプリの設定情報を保持するモデルクラス
class AppConfig {
  /// レストランオーナーのAmazon cognito UID
  //* 本来はnon-nullableが良いが、
  //*　AppConfigが設定される前に他の値を取得するエラーが発生→取得前の状態をnullとする
  final String? ownerId;

  /// 表示モード ('normal' または 'device')
  final String displayMode;

  /// プレビューモードかどうか
  final bool isPreviewMode;

  /// コンストラクタ
  const AppConfig({
    this.ownerId,
    this.displayMode = 'normal',
    this.isPreviewMode = false,
  });

  /// 新しい設定でインスタンスを作成するメソッド
  AppConfig copyWith({
    String? ownerId,
    String? displayMode,
    bool? isPreviewMode,
  }) {
    return AppConfig(
      ownerId: ownerId ?? this.ownerId,
      displayMode: displayMode ?? this.displayMode,
      isPreviewMode: isPreviewMode ?? this.isPreviewMode,
    );
  }
}

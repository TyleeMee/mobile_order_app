mixin NotifierMounted {
  bool _mounted = true;

  // Notifier が現在マウントされているかどうか
  void setUnmounted() => _mounted = false;

  // Notifier が現在マウントされているかどうか取得
  bool get mounted => _mounted;
}

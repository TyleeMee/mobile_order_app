import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_order_app/src/constants/app_color.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_sizes.dart';

/// Custom image widget that loads an image from Firebase Storage or local assets.
class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.p4),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder:
              placeholder ??
              (context, url) => Shimmer.fromColors(
                baseColor: shimmerBaseColor!,
                highlightColor: shimmerHighlightColor!,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                ),
              ),
          errorWidget:
              errorWidget ??
              (context, url, error) => const Center(child: Icon(Icons.error)),
          // オプション: より堅牢なエラー処理を追加
          errorListener: (e) {
            debugPrint("画像の読み込みエラー: $e");
            // エラーを処理、再読み込みを試すか、代替画像を使用する
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

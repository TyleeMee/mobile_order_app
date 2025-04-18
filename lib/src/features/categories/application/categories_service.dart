import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_order_app/src/features/categories/data/categories_repository.dart';
import 'package:mobile_order_app/src/features/categories/data/category_sequence_repository.dart';
import 'package:mobile_order_app/src/features/categories/domain/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_service.g.dart';

class CategoriesService {
  const CategoriesService(
    this._categoriesRepository,
    this._categorySequenceRepository,
  );
  final CategoriesRepository _categoriesRepository;
  final CategorySequenceRepository _categorySequenceRepository;

  /// カテゴリを順序情報に基づいて取得する関数
  Future<List<Category>> getSortedCategories() async {
    // カテゴリデータと順序情報を並行して取得
    final categories = await _categoriesRepository.fetchCategories();
    final categoryIds =
        await _categorySequenceRepository.fetchCategorySequence();

    // 順序情報がない場合はデフォルトの順序（更新日時など）でカテゴリを返す
    if (categoryIds.isEmpty) {
      return categories..sort((a, b) => b.updated.compareTo(a.updated));
    }

    // カテゴリをマップに変換して検索を効率化
    final categoryMap = {
      for (final category in categories) category.id: category,
    };

    // 指定された順序でカテゴリを並び替え
    final sortedCategories =
        categoryIds
            .where((id) => categoryMap.containsKey(id)) // 存在するカテゴリのみフィルタリング
            .map((id) => categoryMap[id]!)
            .toList();

    // 順序情報にないカテゴリ（新しく追加されたものなど）を末尾に追加
    final unsortedCategories =
        categories
            .where((category) => !categoryIds.contains(category.id))
            .toList();

    return [...sortedCategories, ...unsortedCategories];
  }
}

// Provider
@Riverpod(keepAlive: true)
CategoriesService categoriesService(Ref ref) {
  final categoriesRepository = ref.watch(categoriesRepositoryProvider);
  final categorySequenceRepository = ref.watch(
    categorySequenceRepositoryProvider,
  );
  return CategoriesService(categoriesRepository, categorySequenceRepository);
}

// ソート済みカテゴリのプロバイダー
@riverpod
Future<List<Category>> sortedCategories(Ref ref) {
  final categoriesService = ref.watch(categoriesServiceProvider);
  return categoriesService.getSortedCategories();
}

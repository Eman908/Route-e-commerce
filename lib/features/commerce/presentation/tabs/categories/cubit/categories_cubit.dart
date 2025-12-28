import 'package:e_commerce/core/base/base_cubit.dart';
import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/di/di.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:e_commerce/features/commerce/domain/repositry/home_repo.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/categories/cubit/categories_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesCubit
    extends BaseCubit<CategoriesState, CategoriesActions, void> {
  CategoriesCubit() : super(CategoriesState());
  final HomeRepo _homeRepo = getIt();
  @override
  Future<void> doAction(CategoriesActions action) async {
    switch (action) {
      case LoadCategories():
        _loadCategories();
    }
  }

  Future<void> _loadCategories() async {
    safeEmit(state.copyWith(categoriesStatus: const BaseStatus.loading()));
    var response = await _homeRepo.getAllCategories();
    switch (response) {
      case Success<List<CategoriesEntity>>():
        safeEmit(
          state.copyWith(
            categoriesStatus: BaseStatus.success(data: response.data),
          ),
        );
      case Failure<List<CategoriesEntity>>():
        safeEmit(
          state.copyWith(
            categoriesStatus: BaseStatus.failure(message: response.message),
          ),
        );
    }
  }
}

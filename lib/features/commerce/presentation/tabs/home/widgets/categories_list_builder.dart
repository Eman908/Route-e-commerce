import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesListBuilder extends StatelessWidget {
  const CategoriesListBuilder({super.key, required this.categoriesEntity});

  final List<CategoriesEntity> categoriesEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heightSize * .32,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesEntity.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return CategoryCard(categoriesEntity: categoriesEntity[index]);
        },
      ),
    );
  }
}

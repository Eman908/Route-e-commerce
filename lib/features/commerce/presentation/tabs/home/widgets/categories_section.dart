import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, required this.categoriesEntity});
  final List<CategoriesEntity> categoriesEntity;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Categories',
              style: context.textStyle.bodyLarge!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('view all')),
          ],
        ),
        SizedBox(
          height: 200,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoriesEntity.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return Text(
                categoriesEntity[index].name ?? 'heheh',
                style: const TextStyle(color: Colors.red),
              );
            },
          ),
        ),
      ],
    );
  }
}

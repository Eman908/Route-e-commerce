import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/categories_section_builder.dart';
import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
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
        ).horizontalPadding(16),
        const CategoriesSectionBuilder(),
      ],
    );
  }
}

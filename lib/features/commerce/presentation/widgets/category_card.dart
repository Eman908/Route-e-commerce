import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/routing/routes.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/categories_entity.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.categoriesEntity});
  final CategoriesEntity categoriesEntity;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(Routes.productsRoute, arguments: categoriesEntity);
      },
      child: Column(
        spacing: 8,
        children: [
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: CachedNetworkImage(
                  imageUrl: categoriesEntity.image ?? 'No Image',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.textStyle.bodySmall!.fontSize! * 2.4,
            child: Text(
              categoriesEntity.name ?? 'Category Name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/domain/entity/banner_entity.dart';
import 'package:flutter/material.dart';

class HomeBannerCard extends StatelessWidget {
  const HomeBannerCard({super.key, required this.bannerEntity});
  final BannerEntity bannerEntity;
  @override
  Widget build(BuildContext context) {
    final isStartAligned = bannerEntity.alignment == Alignment.centerRight;

    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(bannerEntity.imagePath),
          ),
        ),
        child: Column(
          spacing: 8,
          crossAxisAlignment: isStartAligned
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bannerEntity.title,
                  style: context.textStyle.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isStartAligned
                        ? AppColors.darkBlue
                        : AppColors.white,
                  ),
                ),
                Text(
                  bannerEntity.categoryName,
                  style: context.textStyle.bodyLarge!.copyWith(
                    color: isStartAligned
                        ? AppColors.darkBlue
                        : AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                backgroundColor: bannerEntity.btnColor,
                foregroundColor: bannerEntity.textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/utils/padding_extension.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/cubit/home_state.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/home/widgets/banner_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerSectionBuilder extends StatelessWidget {
  const BannerSectionBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final status = state.bannersStatus?.status;

        if (status == Status.loading) {
          return const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (status == Status.failure) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              state.bannersStatus!.message!,
              textAlign: TextAlign.center,
            ),
          );
        }

        final banners = state.bannersStatus?.data;
        if (banners == null || banners.isEmpty) {
          return Container(
            alignment: Alignment.center,
            child: const Text(
              'No banners available',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        return BannerItemBuilder(bannerEntity: banners).horizontalPadding(16);
      },
    );
  }
}

import 'package:e_commerce/core/base/base_status.dart';
import 'package:e_commerce/core/theme/app_colors.dart';
import 'package:e_commerce/core/utils/context_extension.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/favorites/cubit/fav_cubit.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/favorites/cubit/fav_state.dart';
import 'package:e_commerce/features/commerce/presentation/tabs/favorites/widgets/favorite_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  late FavCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit = context.read<FavCubit>();

      cubit.doAction(LoadAllFavList());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        switch (state.favList.status) {
          case Status.initial:
          case Status.success:
            final favList = state.favList.data ?? [];
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: favList.length,
              itemBuilder: (context, index) {
                return FavoriteCard(productsEntity: favList[index]);
              },
            );
          case Status.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    state.favList.message ?? 'Failed to load products',
                    textAlign: TextAlign.center,
                    style: context.textStyle.bodyLarge!.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                ],
              ),
            );
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

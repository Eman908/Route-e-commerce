// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/auth/data/data_source/contract/api_data_source.dart'
    as _i747;
import '../../features/auth/data/data_source/contract/local_data_source.dart'
    as _i817;
import '../../features/auth/data/data_source/impl/api_data_source_impl.dart'
    as _i80;
import '../../features/auth/data/data_source/impl/local_data_source_impl.dart'
    as _i1008;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/use_case/sign_up_use_case.dart' as _i426;
import '../../features/auth/presentation/login/cubit/login_cubit.dart' as _i179;
import '../../features/auth/presentation/register/cubit/register_cubit.dart'
    as _i404;
import '../../features/commerce/data/datasource/contract/banners_local_data_source.dart'
    as _i804;
import '../../features/commerce/data/datasource/contract/commerce_api_data_source.dart'
    as _i608;
import '../../features/commerce/data/datasource/impl/banners_local_data_source_impl.dart'
    as _i488;
import '../../features/commerce/data/datasource/impl/commerce_api_data_source_impl.dart'
    as _i335;
import '../../features/commerce/data/mappers/commerce_mapper.dart' as _i660;
import '../../features/commerce/data/repo/home_repo_impl.dart' as _i594;
import '../../features/commerce/domain/repositry/home_repo.dart' as _i811;
import '../../features/commerce/presentation/tabs/categories/cubit/categories_cubit.dart'
    as _i854;
import '../../features/commerce/presentation/tabs/home/cubit/home_cubit.dart'
    as _i791;
import '../api%20manager/api_client.dart' as _i335;
import 'module/asset_bundle_module.dart' as _i283;
import 'module/dio_module.dart' as _i556;
import 'module/shared_preference_module.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferenceModule = _$SharedPreferenceModule();
    final assetBundleModule = _$AssetBundleModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferenceModule.getPrefInstance(),
      preResolve: true,
    );
    gh.factory<_i179.LoginCubit>(() => _i179.LoginCubit());
    gh.factory<_i404.RegisterCubit>(() => _i404.RegisterCubit());
    gh.factory<_i660.CommerceMapper>(() => _i660.CommerceMapper());
    gh.factory<_i791.HomeCubit>(() => _i791.HomeCubit());
    gh.factory<_i854.CategoriesCubit>(() => _i854.CategoriesCubit());
    gh.singleton<_i281.AssetBundle>(() => assetBundleModule.getAssetBundle());
    gh.singleton<_i361.Dio>(() => dioModule.dioProvider());
    gh.singleton<_i335.ApiClient>(() => _i335.ApiClient(gh<_i361.Dio>()));
    gh.factory<_i608.CommerceApiDataSource>(
      () => _i335.CommerceApiDataSourceImpl(),
    );
    gh.factory<_i811.HomeRepo>(() => _i594.HomeRepoImpl());
    gh.factory<_i804.BannersLocalDataSource>(
      () => _i488.BannersLocalDataSourceImpl(gh<_i409.AssetBundle>()),
    );
    gh.factory<_i817.LocalDataSource>(
      () => _i1008.LocalDataSourceImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i747.ApiDataSource>(
      () => _i80.ApiDataSourceImpl(gh<_i335.ApiClient>()),
    );
    gh.factory<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(
        gh<_i747.ApiDataSource>(),
        gh<_i817.LocalDataSource>(),
      ),
    );
    gh.factory<_i426.SignUpUseCase>(
      () => _i426.SignUpUseCase(gh<_i170.AuthRepo>()),
    );
    return this;
  }
}

class _$SharedPreferenceModule extends _i460.SharedPreferenceModule {}

class _$AssetBundleModule extends _i283.AssetBundleModule {}

class _$DioModule extends _i556.DioModule {}

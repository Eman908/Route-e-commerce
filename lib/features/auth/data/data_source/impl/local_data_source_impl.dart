import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:e_commerce/core/errors/results.dart';
import 'package:e_commerce/core/errors/safe_call.dart';
import 'package:e_commerce/features/auth/data/data_source/contract/local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  SharedPreferences sharedPreferences;
  LocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> saveToke(String token) async {
    safeCall(() async {
      await sharedPreferences.setString(AppConstants.token, token);
      return Success(null);
    });
  }
}

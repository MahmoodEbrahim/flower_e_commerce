import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
@injectable
class OrderDateHelper {
  final SharedPreferences _sharedPreferences;

  OrderDateHelper(this._sharedPreferences);
  static const String _key = Constants.sharedPrefrenceDataKey;

   Future<void> addOrderDate() async {
    
    final List<String> dates = _sharedPreferences.getStringList(_key) ?? [];
    final now = DateFormat(Constants.dateFormat).format(DateTime.now());
    dates.add(now);
    await _sharedPreferences.setStringList(_key, dates);
  }

   Future<List<String>> getOrderDates() async {
    
    return _sharedPreferences.getStringList(_key) ?? [];
  }

   Future<void> clearAllOrderDates() async {
    
    await _sharedPreferences.remove(_key);
  }
}

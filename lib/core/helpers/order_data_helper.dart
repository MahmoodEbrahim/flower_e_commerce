import 'package:flower_e_commerce/core/utils/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
@injectable
class OrderDateHelper {
  final SharedPreferences _sharedPreferences;

  OrderDateHelper(this._sharedPreferences);
  

   Future<void> addOrderDate(String orderId) async {
    
    final List<String> dates = _sharedPreferences.getStringList('dates_$orderId') ?? [];
    final now = DateFormat(Constants.dateFormat).format(DateTime.now());
    dates.add(now);
    await _sharedPreferences.setStringList('dates_$orderId', dates);
  }

   Future<List<String>> getOrderDates(String orderId) async {
    
    return _sharedPreferences.getStringList('dates_$orderId') ?? [];
  }

   Future<void> clearAllOrderDates(String orderId) async {
    
    await _sharedPreferences.remove('dates_$orderId');
  }
}

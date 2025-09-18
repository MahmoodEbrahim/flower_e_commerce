import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/api/source/user_local_storage.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';

import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter/material.dart';



class DeliveryLocation extends StatelessWidget {
  
  const DeliveryLocation({super.key,});

  @override
  Widget build(BuildContext context) {

    final t = AppLocalizations.of(context)!;
    final  UserModel userModel;
    final  List<AddressEntity> address;
     final  LoginModel? loginModel;
 
    String location = t.noLocationFound;

    loginModel = UserLocalStorage.getUser();

    if (loginModel != null) {
       userModel = loginModel.user;
       address = userModel.addresses;
      if (address.isNotEmpty) {
        location = " ${address[0].city} ${address[0].street}}";
      }
    }

   
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Icon(Icons.location_on_outlined)),
        Expanded(
          flex: 18,
          child: Text(
                   location,
                  style: getRegularStyle(
                    color: AppColors.black,
                    
                    fontSize: FontSize.s18,
                  ),
                ),
          ),
        
        Expanded(
          flex: 2,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';

class CustumRadioTile extends StatefulWidget {
  final String? value;
  final ValueNotifier<String?> groupValue;
  

  const CustumRadioTile({
    super.key,
    this.value,
    required this.groupValue,
  
  });

  @override
  State<CustumRadioTile> createState() => _CustumRadioTileState();
}

class _CustumRadioTileState extends State<CustumRadioTile> {
  String? groupValue;
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: FormField<String>(validator: (value) {
          if (value == null || value.isEmpty) {
            return t.pleaseSelectGender;
          } else {
            return null;
          }
        }, builder: (state) {
          if (!state.hasError) {}
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: Text(
                        t.gender,
                        style: getBoldStyle(
                            fontSize: FontSize.s18, color: AppColors.Black),
                      )),
                  Expanded(
                      flex: 9,
                      child: RadioListTile(
                          value: "female",
                          fillColor: WidgetStateProperty.all(AppColors.Pink),
                          title: Text(
                            t.female,
                            style: getRegularStyle(
                                fontSize: 15, color: AppColors.black),
                          ),
                          groupValue: widget.value,
                          onChanged: (val) {
                            widget.groupValue.value = val;
                            state.didChange(val);
                              
                          })),
                  Expanded(
                      flex: 8,
                      child: RadioListTile(
                          fillColor: WidgetStateProperty.all(AppColors.Pink),
                          value: "male",
                          title: Text(
                            t.male,
                            style: getRegularStyle(
                                fontSize: 15, color: AppColors.black),
                          ),
                          groupValue: widget.value,
                          onChanged: (val) {
                            widget.groupValue.value = val;
                            state.didChange(val);
                           
                          })),
                ],
              ),
              if (state.hasError)
                Text(
                  state.errorText!,
                  style: TextStyle(color: AppColors.red),
                ),
            ],
          );
        }));
  }
}

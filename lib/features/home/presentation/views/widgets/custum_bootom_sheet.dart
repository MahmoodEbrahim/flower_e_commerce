import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flutter/material.dart' hide RadioGroup;
import 'package:radio_group_v2/radio_group_v2.dart';



class CustumBootomSheet extends StatefulWidget {
 
  const CustumBootomSheet({super.key});

  @override
  State<CustumBootomSheet> createState() => _CustumBootomSheetState();
}

class _CustumBootomSheetState extends State<CustumBootomSheet> {
  String? selectedValue;
  final RadioGroupController<String> controller = RadioGroupController();
  final List<String> options = [
    "Lower Price",
    "Highest Price",
    "New",
    "Old",
    "Discount",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              
              child: Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Sort by",
              textAlign: TextAlign.start,
              style: getBoldStyle(color: AppColors.pink, fontSize: FontSize.s20),
            ),
          ),
       
          SizedBox(
            height: 300,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                String value = options[index];

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blackColor[10]!,
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                    color: AppColors.whiteColor[10],
                  ),
                  child: RadioListTile<String>(
                    fillColor: WidgetStateProperty.all(AppColors.pink),
                    value: value,
                    groupValue: selectedValue,
                    onChanged: (val) {
                      setState(() {
                        selectedValue = val;
                      });
                    },
                    title: Text(
                      value,
                      style: getBoldStyle(
                        color: AppColors.black,
                        fontSize: FontSize.s16,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.filter_alt_rounded),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text("Filter"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

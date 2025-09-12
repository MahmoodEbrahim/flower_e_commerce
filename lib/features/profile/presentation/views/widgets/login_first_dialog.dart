
  import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';

Future<dynamic> loginInDialgo(BuildContext context, AppLocalizations t) {
    return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(child: Text(t.login),),
                          content: Text("you do not have an account"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(t.cancel,
                                  style: getRegularStyle(color: AppColors.black)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context); // close dialog
                                Navigator.pushNamed(context, AppRoutes.login);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.pink,
                              ),
                              child: Text(
                                t.login,
                                style: getRegularStyle(color: AppColors.white),
                              ),
                            ),
                          ],
                        ),
                      );
  }

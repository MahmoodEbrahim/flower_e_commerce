import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../Features/Home/Presentation/Widgets/Tabs/HomeTab.dart';
import '../../features/home/presentation/Pages/home_page.dart';

class Routes {
  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: GetIt.instance<HomeBloc>(),
            child: HomePage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

class AppRoutes {
  static const String home = '/home';
}

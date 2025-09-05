import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flower_e_commerce/core/utils/constants/string_manager.dart';
import 'package:flower_e_commerce/features/cart/presentation/view/pages/cart_page.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/views/Tabs/card_tab.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/categories_page.dart';
import 'package:flower_e_commerce/features/home/presentation/views/pages/home_page.dart';
import 'package:flower_e_commerce/features/profile/presentation/views/pages/profile_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomePageState();
}

class _HomePageState extends State<MainLayout> {
  late CategoriesViewModel categoriesViewModel =
      getIt.get<CategoriesViewModel>();

  int selectedIndex = 0;
  late final List<Widget> tabs;
  int? catIndex;

  @override
  void initState() {
    super.initState();
    tabs = [
      BlocProvider.value(
        value: categoriesViewModel,
        child: HomePage(
          onChangeTab: (value) {
            setState(() {
              selectedIndex = value.tabIndex;
              catIndex = value.categoryIndex;
            
            });
          },
        ),
      ),
      BlocProvider.value(
        value: categoriesViewModel,
        child: CategoriesPage(
          catIndex: catIndex,
        ),
      ),
      CartPage(),
      ProfileMainPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.pink),
          ),
        ),
      ),
      child: Scaffold(
        body: tabs[selectedIndex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          elevation: 2,
          indicatorColor: Colors.transparent,
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.homeicon,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
              label: StringsManager.homeTab,
              selectedIcon: SvgPicture.asset(
                AssetsManager.homeicon,
                colorFilter: ColorFilter.mode(
                  Colors.pink,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.categoriesicon,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
              label: StringsManager.categoriesTab,
              selectedIcon: SvgPicture.asset(
                AssetsManager.categoriesicon,
                colorFilter: ColorFilter.mode(
                  Colors.pink,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.carticon,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
              label: StringsManager.cartTab,
              selectedIcon: SvgPicture.asset(
                AssetsManager.carticon,
                colorFilter: ColorFilter.mode(
                  Colors.pink,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
            ),
            NavigationDestination(
              icon: SvgPicture.asset(
                AssetsManager.profileicon,
                colorFilter: const ColorFilter.mode(
                  Colors.grey,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
              label: StringsManager.profileTab,
              selectedIcon: SvgPicture.asset(
                AssetsManager.profileicon,
                colorFilter: ColorFilter.mode(
                  Colors.pink,
                  BlendMode.srcIn,
                ),
                width: 26,
                height: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

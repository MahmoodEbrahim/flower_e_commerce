import 'package:flower_e_commerce/core/utils/constants/assets_manager.dart';
import 'package:flower_e_commerce/core/utils/constants/string_manager.dart';
import 'package:flower_e_commerce/features/home/presentation/views/Tabs/card_tab.dart';
import 'package:flower_e_commerce/features/home/presentation/views/Tabs/categories_tab.dart';
import 'package:flower_e_commerce/features/home/presentation/views/Tabs/home_tab.dart';
import 'package:flower_e_commerce/features/home/presentation/views/Tabs/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _HomePageState();
}

class _HomePageState extends State<MainLayout> {
  int selectedIndex = 0;

  final List<Widget> tabs = [
    HomeTab(),CategoriesTab(),
    CartTab(),ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color:Colors.pink),
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
              label: StringsManager.HomeTab,
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
              label: StringsManager.CategoriesTab,
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
              label: StringsManager.CartTab,
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
              label: StringsManager.ProfileTab,
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







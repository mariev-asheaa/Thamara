import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thamara/features/settings/presentation/views/settings_view.dart';

import '../../../core/widgets/custome_nav_bar.dart';
import '../../home/presentation/home_view.dart';
import '../../plant details/presentation/views/all_plants_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeView(),
    const AllPlantsView(),
    const Center(child: Text("My Plants")),
    const  SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],

      bottomNavigationBar:
      SafeArea
        (
        top: false,
        child: CustomNavBar(
          selectedIndex: currentIndex,
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

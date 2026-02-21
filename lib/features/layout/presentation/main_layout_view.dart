import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thamara/features/profile/presentation/profile_view.dart';

import '../../../core/widgets/custome_nav_bar.dart';
import '../../home/presentation/home_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeView(),
    const Center(child: Text("Tracking")),
    const Center(child: Text("My Plants")),
    const  ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentIndex],

      bottomNavigationBar: CustomNavBar(
        selectedIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

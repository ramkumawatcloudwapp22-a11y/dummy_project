import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../providers/nav_provider.dart';
import '../../widgets/app_bottom_nav.dart';
import '../downloads/downloads_screen.dart';
import '../drone/drone_screen.dart';
import '../profile/profile_screen.dart';
import '../training/training_center_screen.dart';
import 'dashboard_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: const _ShellView(),
    );
  }
}

class _ShellView extends StatelessWidget {
  const _ShellView();

  @override
  Widget build(BuildContext context) {
    final index = context.watch<NavProvider>().currentIndex;

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: const [
          DashboardScreen(),
          TrainingCenterScreen(),
          DroneScreen(),
          DownloadsScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

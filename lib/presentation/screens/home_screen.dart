import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elimu Pepe"),
        backgroundColor: AppColors.primaryBlue,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Student"),
              accountEmail: Text("user@elimu.pepe"),
              decoration: BoxDecoration(color: AppColors.deepBlue),
            ),
            _buildDrawerItem(
              Icons.dashboard,
              "Dashboard",
              const DashboardScreen(),
              context,
            ),
            _buildDrawerItem(
              Icons.book,
              "My Learning Areas",
              const Scaffold(),
              context,
            ),
            // Add remaining items here...
          ],
        ),
      ),
      body: const DashboardScreen(),
    );
  }

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    Widget page,
    BuildContext context,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryBlue),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}

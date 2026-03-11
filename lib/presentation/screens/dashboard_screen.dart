import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _handleRefresh() async {
    // Simulate API call to fetch updated progress
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGray,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppColors.primaryBlue,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // 1. Gradient Header with Search
              Container(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.deepBlue],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "jambo, Student!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search courses, labs, or books...",
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.primaryBlue,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Animated Progress Tracker
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Continue Learning",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildAnimatedProgress(),

                    // 3. Quick Access Grid
                    const SizedBox(height: 30),
                    const Text(
                      "Quick Access",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      mainAxisSpacing: 15,
                      children: [
                        _buildQuickIcon(Icons.science, "Labs"),
                        _buildQuickIcon(Icons.tv, "Loho TV"),
                        _buildQuickIcon(Icons.quiz, "Quest"),
                        _buildQuickIcon(Icons.videogame_asset, "Games"),
                        _buildQuickIcon(Icons.badge, "Badges"),
                        _buildQuickIcon(Icons.question_answer, "Help"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedProgress() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 0.65),
      duration: const Duration(seconds: 2),
      builder: (context, value, _) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Mathematics Grade 8"),
                Text("${(value * 100).toInt()}%"),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: value,
              color: AppColors.accentOrange,
              backgroundColor: AppColors.surfaceGray,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.primaryBlue,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

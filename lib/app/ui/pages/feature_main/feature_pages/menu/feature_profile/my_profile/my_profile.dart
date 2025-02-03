import 'package:flutter/material.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_profile/my_profile/tabs/security.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_profile/my_profile/tabs/view_profile.dart';
import '../../../../../../../core/models/profile/profile_data.dart';
import '../../../../../../../utils/lang/colors.dart';
import 'tabs/login_activity.dart';
import 'tabs/notifications.dart';

class ViewProfileScreen extends StatefulWidget {
  final int initialTabIndex;
  final ProfileData? profileData;

  const ViewProfileScreen({super.key, this.initialTabIndex = 0, required this.profileData}); // Default to tab 0

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTabIndex);
    _pageController = PageController(initialPage: widget.initialTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChanged(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 20)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black38,
          indicatorWeight: 0.75,
          dividerColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontSize: 12),
          onTap: _onTabTapped, // Handle tab tap to switch page
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Profile'),
            Tab(icon: Icon(Icons.notifications), text: 'Notifications'),
            Tab(icon: Icon(Icons.show_chart), text: 'Activity'),
            Tab(icon: Icon(Icons.lock), text: 'Security'),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged, // Handle page swipe to switch tab
        children: [
          ProfileViewScreen(profileData: widget.profileData),
          const ProfileNotificationsScreen(),
          ProfileLoginActivityScreen(
            loginLogData: widget.profileData!.loginLog,
          ),
          const ProfileSecurityScreen(),
        ],
      ),
    );
  }
}

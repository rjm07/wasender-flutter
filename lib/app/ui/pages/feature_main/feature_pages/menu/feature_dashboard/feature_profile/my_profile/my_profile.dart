import 'package:flutter/material.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/feature_profile/my_profile/tabs/security.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_dashboard/feature_profile/my_profile/tabs/view_profile.dart';
import 'tabs/login_activity/login_activity.dart';
import 'tabs/notifications.dart';

class ViewProfileScreen extends StatefulWidget {
  final int initialTabIndex;

  const ViewProfileScreen({super.key, this.initialTabIndex = 0}); // Default to tab 0

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
        title: const Text('My Profile', style: TextStyle(color: Colors.black, fontSize: 20)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green.shade300,
          unselectedLabelColor: Colors.black54,
          indicatorWeight: 1,
          dividerColor: Colors.black26,
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
        children: const [
          ProfileViewScreen(),
          ProfileNotificationsScreen(),
          ProfileLoginActivityScreen(),
          ProfileSecurityScreen(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_categories/bot_chat_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_categories/close_chat_screen.dart';

import '../../../../../../utils/lang/colors.dart';
import '../../../../../../utils/lang/images.dart';
import 'chats/chat_categories/active_chat_screen.dart';

class PesanScreen extends StatefulWidget {
  final int initialPageIndex;
  const PesanScreen({super.key, this.initialPageIndex = 0});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController = PageController();
  late TabController _tabController;
  int activeBadgeCount = 0; // Example badge counts
  int closedBadgeCount = 0;
  int openBadgeCount = 0;

  int _selectedFilterIndex = 0; // Track the selected filter

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();

    // Sync TabBar and PageView
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Method to handle filter selection
  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  // Method to handle page changes via swipes
  void _onPageChanged(int index) {
    setState(() {
      // Update this if you want to change the selected filter based on the page
    });
  }

  final List<Widget> _pages = [
    ActiveChatScreen(),
    ClosedChatScreen(),
    BotChatScreen(),
  ];

  Widget buildBadge(int count) {
    if (count == 0) return SizedBox.shrink();
    return Positioned(
      right: 10,
      top: 14,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Text(
          count.toString(),
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ),
    );
  }

  Widget tabWithBadge(String title, int badgeCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(child: Text(title)),
        if (badgeCount > 0) buildBadge(badgeCount),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Add logic for logo tap
              },
              child: Image.asset(
                CustomImages.imageWaSenderLogo, // Replace with your logo asset path
                height: 30,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        backgroundColor: AppColors.navBarColor,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      color: AppColors.primary,
                      CustomIcons.iconViewContact,
                      height: 20,
                      width: 20,
                    )),
                const SizedBox(width: 28),
                GestureDetector(onTap: () {}, child: const Icon(Icons.add_box_outlined, color: AppColors.primary)),
                const SizedBox(width: 18),
                GestureDetector(onTap: () {}, child: const Icon(Icons.more_vert_rounded, color: AppColors.primary)),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
        elevation: 1,
      ),
      body: Column(
        children: [
          // Filter buttons row
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.blueGrey.shade50,
                  height: 64,
                  child: TabBar(
                    dividerHeight: 0,
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.black45,
                    indicatorColor: AppColors.primary,
                    indicatorWeight: 3.0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(fontSize: 14),
                    tabs: [
                      tabWithBadge("Active", activeBadgeCount),
                      tabWithBadge("Closed", closedBadgeCount),
                      tabWithBadge("Open (Bot)", openBadgeCount),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "MESSAGES",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // PageView for different screens
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const BouncingScrollPhysics(),
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a filter button
  Widget _buildFilterButton(String text, int index) {
    return GestureDetector(
      onTap: () => _onFilterSelected(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          decoration: BoxDecoration(
            color: _selectedFilterIndex == index ? Colors.greenAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            text,
            style: TextStyle(
              color: _selectedFilterIndex == index ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}

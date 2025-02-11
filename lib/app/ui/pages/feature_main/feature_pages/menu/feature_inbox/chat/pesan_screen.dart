import 'package:flutter/material.dart';

import '../../../../../../../core/services/navigation/navigation.dart';
import '../../../../../../../utils/lang/colors.dart';
import '../../../../../../../utils/lang/images.dart';
import 'chats/chat_categories/active_chat_screen.dart';
import 'chats/chat_categories/bot_chat_screen.dart';
import 'chats/chat_categories/close_chat_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  static const routeName = '/pesan';
  final int initialPageIndex;
  const ChatHomeScreen({super.key, this.initialPageIndex = 0});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController = PageController();
  late TabController _tabController;
  int activeBadgeCount = 0; // Example badge counts
  int closedBadgeCount = 0;
  int openBadgeCount = 0;

  //int _selectedFilterIndex = 0; // Track the selected filter

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

  void onHandleTicket() {
    _tabController.animateTo(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Method to handle filter selection
  // void _onFilterSelected(int index) {
  //   setState(() {
  //     _selectedFilterIndex = index;
  //   });
  // }

  // Method to handle page changes via swipes
  void _onPageChanged(int index) {
    setState(() {
      // Update this if you want to change the selected filter based on the page
    });
  }

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            NavService.jumpToPageID('/main');
          },
        ),
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
        bottom: TabBar(
            controller: _tabController,
            dividerHeight: 0,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.black45,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3.0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontSize: 14),
            tabs: const [
              Tab(
                text: 'Active',
              ),
              Tab(
                text: 'Closed',
              ),
              Tab(
                text: 'Open',
              ),
            ]),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter buttons row
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(
                    height: 16,
                  ),
                  // Container(
                  //   color: Colors.blueGrey.shade50,
                  //   height: 64,
                  //   child: TabBarView(
                  //     controller: _tabController,
                  //     children: [],
                  //   ),
                  // ),
                ],
              ),
            ),
            // PageView for different screens
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const BouncingScrollPhysics(),
                children: [
                  ActiveChatScreen(
                    onHandleTicket: () {},
                  ),
                  ClosedChatScreen(
                    onHandleTicket: () {},
                  ),
                  BotChatScreen(
                    onHandleTicket: onHandleTicket,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   // Helper method to build a filter button
//   Widget _buildFilterButton(String text, int index) {
//     return GestureDetector(
//       onTap: () => _onFilterSelected(index),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         child: Container(
//           decoration: BoxDecoration(
//             color: _selectedFilterIndex == index ? Colors.greenAccent : Colors.grey[300],
//             borderRadius: BorderRadius.circular(20),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Text(
//             text,
//             style: TextStyle(
//               color: _selectedFilterIndex == index ? Colors.white : Colors.black54,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
}

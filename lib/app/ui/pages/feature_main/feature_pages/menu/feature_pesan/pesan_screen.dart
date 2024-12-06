import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_categories/bot_chat_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/chats/chat_categories/close_chat_screen.dart';
import '../../../../../../core/services/socket_io/socket.dart';
import '../../../../../../utils/lang/images.dart';
import 'chats/chat_categories/active_chat_screen.dart';

class PesanScreen extends StatefulWidget {
  const PesanScreen({super.key});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController = PageController();
  late TabController _tabController;
  final logger = Logger();
  late socket_io.Socket? socket;
  final SocketService socketService = SocketService();

  int _selectedFilterIndex = 0; // Track the selected filter

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
    socket = socketService.initializeSocket();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WASenderApp'),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      color: Colors.green,
                      CustomIcons.iconViewContact,
                      height: 20,
                      width: 20,
                    )),
                const SizedBox(width: 28),
                GestureDetector(onTap: () {}, child: const Icon(Icons.add_box_outlined, color: Colors.green)),
                const SizedBox(width: 18),
                GestureDetector(onTap: () {}, child: const Icon(Icons.more_vert_rounded, color: Colors.green)),
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
            padding: const EdgeInsets.symmetric(vertical: 4),
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
                    labelColor: Colors.green,
                    unselectedLabelColor: Colors.black45,
                    indicatorColor: Colors.green,
                    indicatorWeight: 3.0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(fontSize: 14),
                    tabs: const [
                      Tab(text: "Active"),
                      Tab(text: "Closed"),
                      Tab(text: "Open (Bot)"),
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

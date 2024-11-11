import 'package:flutter/material.dart';
import 'chats/chat_user_screen.dart';

class PesanScreen extends StatefulWidget {
  const PesanScreen({super.key});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  final PageController _pageController = PageController();
  int _selectedFilterIndex = 0; // Track the selected filter

  @override
  void dispose() {
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
    const ChatUserScreen(),
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
                GestureDetector(onTap: () {}, child: const Icon(Icons.camera_alt, color: Colors.black54)),
                const SizedBox(width: 16),
                GestureDetector(onTap: () {}, child: const Icon(Icons.search, color: Colors.black54)),
                const SizedBox(width: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      _buildFilterButton('All', 0),
                      _buildFilterButton('Unread', 1),
                      _buildFilterButton('Favorites', 2),
                      _buildFilterButton('Groups', 3),
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

import 'dart:io' show Platform; // Import Platform for OS detection
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_kontak/kontak_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pembayaran/pembayaran_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pengguna/pengguna_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_perangkat_saya/perangkat_saya_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/pesan_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/menu/sidebar_menu_screen.dart';
import '../../../utils/lang/images.dart';
import 'feature_pages/menu/feature_dashboard/dashboard_screen.dart';
import 'feature_pages/menu/feature_tim_agen/tim_agen_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool showOptions = false;

  void toggleOptions() {
    setState(() {
      showOptions = !showOptions; // Toggle visibility of additional options
    });
  }

  // List of pages for easy management
  final List<Widget> _pages = const [
    DashboardScreen(),
    PerangkatSayaScreen(),
    PesanScreen(),
    KontakScreen(),
    PenggunaScreen(),
    TimAgenScreen(),
    PembayaranScreen(),
  ];

  final List<String> _pageTitles = [
    'Dashboard',
    'Perangkat Saya',
    'Pesan',
    'Kontak',
    'Pengguna',
    'Tim Agen',
    'Pembayaran',
    'Profile',
    'Bantuan',
  ];

  // List of BottomNavigationBar items
  final List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(CustomIcons.iconMainDashboard)),
      label: 'Dashboard',
    ),
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(CustomIcons.iconPerangkatSaya)),
      label: 'Perangkat',
    ),
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(CustomIcons.iconPesan)),
      label: 'Pesan',
    ),
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(CustomIcons.iconMore)),
      label: 'More',
    ),
  ];

  void requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  @override
  void initState() {
    requestNotificationPermission();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the platform is iOS
    final bool isIOS = Platform.isIOS;

    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_currentPage], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
      ),
      // Conditionally display Drawer for Android
      drawer: isIOS ? null : SideBarMenuScreen(pageController: _pageController),
      // Conditionally display BottomNavigationBar for iOS
      bottomNavigationBar: isIOS
          ? BottomNavigationBar(
              currentIndex: _currentPage,
              type: BottomNavigationBarType.fixed,
              items: _bottomNavItems,
              onTap: (index) {
                setState(() {
                  _currentPage = index;
                  _pageController.jumpToPage(index);
                });
              },
            )
          : null,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: _pages,
      ),
      floatingActionButton: SpeedDial(
        // Initial FAB with four squares icon like in the first image
        icon: Icons.apps_rounded,
        backgroundColor: Colors.green.shade700,
        activeIcon: Icons.close,
        activeBackgroundColor: Colors.blue,
        spacing: 12,
        spaceBetweenChildren: 12,
        overlayColor: Colors.black.withOpacity(0.25),

        children: [
          SpeedDialChild(
            child: const Icon(Icons.arrow_forward, color: Colors.white),
            label: 'Berlangganan',
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
            labelBackgroundColor: Colors.transparent,
            labelShadow: [
              const BoxShadow(
                color: Colors.transparent,
              ),
            ],
            backgroundColor: Colors.green,
            onTap: () {
              //print('Tambah Perangkat pressed');
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add, color: Colors.white),
            label: 'Tambah Perangkat',
            labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
            labelBackgroundColor: Colors.transparent,
            labelShadow: [
              const BoxShadow(
                color: Colors.transparent,
              ),
            ],
            backgroundColor: Colors.green,
            onTap: () {
              if (kDebugMode) {
                print('Berlangganan pressed');
              }
            },
          ),
        ],
      ),
    );
  }
}

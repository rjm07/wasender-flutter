import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:wasender/app/core/services/firebase/cloud_messaging.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_kontak/kontak_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pembayaran/pembayaran_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pengguna/pengguna_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_perangkat_saya/perangkat_saya_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/menu/feature_pesan/pesan_screen.dart';
import 'package:wasender/app/ui/pages/feature_main/menu/sidebar_menu_screen.dart';
import '../../../core/services/preferences.dart';
import '../../../utils/lang/colors.dart';
import '../../../utils/lang/images.dart';
import 'feature_pages/menu/feature_dashboard/dashboard_screen.dart';
import 'feature_pages/menu/feature_dashboard/feature_profile/profile_screen.dart';
import 'feature_pages/menu/feature_inbox/inbox_screen.dart';
import 'feature_pages/menu/feature_tim_agen/tim_agen_screen.dart';
import 'feature_pages/pengaturan/feature_bantuan/bantuan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool showOptions = false;

  String userRole = ''; // Declare the userRole variable

  @override
  void initState() {
    super.initState();

    _getUserRoleFromPrefs(); // Fetch the role from SharedPreferences
  }

  // Fetch userRole from LocalPrefs (SharedPreferences)
  Future<void> _getUserRoleFromPrefs() async {
    final prefs = await LocalPrefs.getUserRole();
    setState(() {
      userRole = prefs!;
      debugPrint("User Role: $userRole");
    });
  }

  void toggleOptions() {
    setState(() {
      showOptions = !showOptions; // Toggle visibility of additional options
    });
  }

  // List of pages for easy management
  final List<Widget> _adminPages = const [
    DashboardScreen(),
    PerangkatSayaScreen(),
    InboxScreen(),
    PesanScreen(),
    KontakScreen(),
    PenggunaScreen(),
    TimAgenScreen(),
    PembayaranScreen(),
  ];

  final List<Widget> _agentPages = const [
    DashboardScreen(),
    ProfileScreen(),
    InboxScreen(),
    PesanScreen(),
    KontakScreen(),
    BantuanScreen(),
  ];

  final List<String> _pageTitles = [
    'Dashboard',
    'Perangkat Saya',
    'Inbox',
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
      icon: ImageIcon(AssetImage(CustomIcons.iconInbox)),
      label: 'Inbox',
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
    await FirebaseCloudMessagingService.requestPermission();
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
          title: Text(_pageTitles[_currentPage] == 'Dashboard' ? '' : _pageTitles[_currentPage],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          backgroundColor: _pageTitles[_currentPage] == 'Dashboard' ? AppColors.navBarColor : AppColors.primary),
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
        children: userRole.toUpperCase() != 'AGENT' ? _adminPages : _agentPages,
      ),
      floatingActionButton: SpeedDial(
        // Initial FAB with four squares icon like in the first image
        icon: Icons.apps_rounded,
        backgroundColor: AppColors.primary,
        activeIcon: Icons.close,
        activeBackgroundColor: Colors.blue,
        spacing: 12,
        spaceBetweenChildren: 12,
        overlayColor: Colors.black26,

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
            backgroundColor: AppColors.primary,
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
            backgroundColor: AppColors.primary,
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

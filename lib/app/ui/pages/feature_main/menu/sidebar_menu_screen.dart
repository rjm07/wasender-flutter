import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasender/app/ui/pages/feature_main/feature_pages/pengaturan/feature_paket/paket_screen.dart';
import '../../../../core/services/auth.dart';
import '../../../../utils/lang/images.dart';
import '../../../shared/widgets/custom_list_tiles.dart';
import '../feature_pages/menu/feature_pesan/pesan_screen.dart';

class SideBarMenuScreen extends StatefulWidget {
  final PageController pageController;

  const SideBarMenuScreen({super.key, required this.pageController}); // Accept controller

  @override
  State<SideBarMenuScreen> createState() => _SideBarMenuScreenState();
}

class _SideBarMenuScreenState extends State<SideBarMenuScreen> {
  void _onTileTap(int index) {
    widget.pageController.jumpToPage(index); // Use the passed controller
    Navigator.pop(context); // Close the drawer after selecting a tile
  }

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Drawer(
      child: Container(
        color: Colors.grey.shade300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Center(
                child: Image.asset(
                  CustomImages.imageWaSenderLogoSlogan,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "MENU",
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    children: [
                      SMListTiles(
                        image: CustomIcons.iconMainDashboard,
                        title: 'Main Dashboard',
                        onTap: () => _onTileTap(0),
                      ),
                      SMListTiles(
                        image: CustomIcons.iconPerangkatSaya,
                        title: 'Perangkat Saya',
                        onTap: () => _onTileTap(1),
                      ),
                      SMListTiles(
                        image: CustomIcons.iconPesan,
                        title: 'Pesan',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PesanScreen(),
                            ),
                          );
                        },
                      ),
                      SMListTiles(
                        image: CustomIcons.iconMainDashboard,
                        title: 'Kontak',
                        onTap: () => _onTileTap(4),
                      ),
                      SMListTiles(
                        image: CustomIcons.iconPerangkatSaya,
                        title: 'Pengguna',
                        onTap: () => _onTileTap(5),
                      ),
                      SMListTiles(
                        image: CustomIcons.iconInbox,
                        title: 'Tim Agen',
                        onTap: () => _onTileTap(6),
                      ),
                      SMListTiles(
                        image: CustomIcons.iconPesan,
                        title: 'Pembayaran',
                        onTap: () => _onTileTap(7),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.transparent,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "PENGATURAN",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SMListTiles(
                        image: CustomIcons.iconProfile,
                        title: 'Paket',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PaketScreen(),
                            ),
                          );
                        },
                      ),
                      SMListTiles(
                        image: CustomIcons.iconBantuan,
                        title: 'Bantuan',
                        onTap: () => _onTileTap(9),
                      ),
                      SMListTiles(
                          image: CustomIcons.iconKeluar, title: 'Keluar', onTap: () => _confirmLogout(context, auth)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context, Auth auth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                auth.logout(); // Call the logout method
              },
            ),
          ],
        );
      },
    );
  }
}

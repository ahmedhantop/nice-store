import 'package:flutter/material.dart';
import 'package:nicestore/core/theme/colors.dart';
import 'package:nicestore/core/theme/assets_maneger.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: 20),

            // General Section
            _buildSection('General', [
              _buildListTile(
                icon: Icons.person_outline,
                title: 'Profile Settings',
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.location_on_outlined,
                title: 'Saved Location',
                onTap: () {
                  //    context.pushNewLocation();
                },
              ),

              _buildListTile(
                icon: Icons.percent_outlined,
                title: 'Promo Code List',
                onTap: () {},
              ),
            ]),

            // App Details Section
            _buildSection('App Details', [
              // Add app details items here
              _buildListTile(
                icon: Icons.settings,
                title: 'App Settings',
                onTap: () {
                  //  context.pushSettings();
                },
              ),
              _buildListTile(
                icon: Icons.share,
                title: 'Share App',
                onTap: () {},
              ),
              _buildListTile(
                icon: Icons.chat,
                title: 'Chat Support',
                onTap: () {
                  // context.pushChatSupport();
                },
              ),
            ]),

            // App Details Section
            _buildSection(isAlert: true, 'Alert Zone', [
              // Add app details items here
              _buildListTile(
                isAlert: true,
                icon: Icons.delete,
                title: 'Delete Account',
                onTap: () {},
              ),
              _buildListTile(
                isAlert: true,
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {},
              ),
            ]),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.background,
          radius: 50,
          backgroundImage: AssetImage(AssetsManager.logo),
        ),
        const SizedBox(height: 12),
        const Text(
          'Ahmed Hantop',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        // const SizedBox(height: 4),
        Text(
          'ahmedhantop@gmail.com',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children, {
    bool isAlert = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),

      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isAlert == true ? Colors.red[200] : Colors.grey[300],
          border: Border(
            bottom: BorderSide(
              color: isAlert == true
                  ? Colors.blue
                  : Colors.grey.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                title,
                style: TextStyle(
                  color: (isAlert == true) ? Colors.red : Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(children: children),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool? isAlert = false,
  }) {
    return ListTile(
      subtitle: Divider(height: 1, color: Colors.black),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (isAlert == true) ? Colors.red[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: (isAlert == true) ? Colors.red[200] : Colors.blue,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: (isAlert == true) ? Colors.red : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: (!isAlert!) ? Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}

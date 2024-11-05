import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/strings.dart';
import 'package:tickoyakovendors/features/analytics/presentation/pages/analytics.dart';
import 'package:tickoyakovendors/features/home_screen/presentation/pages/home_screen.dart';
import 'package:tickoyakovendors/features/profile/presentation/pages/profile_screen.dart';
import 'package:tickoyakovendors/features/profile/presentation/widgets/logout_button_widget.dart';
import 'package:tickoyakovendors/features/settings/presentation/pages/settings_screen.dart';
import 'package:tickoyakovendors/features/ticket_scanning/presentation/pages/ticket_scanning.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor,
              AppColors.primaryColor,
              AppColors.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Background decorative elements
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
                Positioned(
                top: 200,
                right: 20,
                child: Container(
                  width: 200,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -120,
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ),
              ),
              // Main content
              Column(
                children: [
                  _buildDrawerHeader(),
                  _buildDrawerBody(context),
                  const Spacer(),
                  _buildDrawerFooter(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white24,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                AppColors.accentColor,
                Colors.white,
              ],
            ).createShader(bounds),
            child: const Text(
              'Vendor Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'vendor@email.com',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerBody(BuildContext context) {
    return Column(
      children: [
        _buildDrawerItem(
          context,
          icon: Icons.dashboard_rounded,
          title: dashboard,
          onTap: () {
            // Add logout logic
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
        _buildDivider(),
        _buildDrawerItem(
          context,
          icon: Icons.person_outline_rounded,
          title: profile,
         onTap: () {
            // Add logout logic
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ProfileScreen()));
          },
        ),
        _buildDivider(),
        _buildDrawerItem(
          context,
          icon: Icons.analytics_outlined,
          title: analytics,
         onTap: () {
            // Add logout logic
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => AnalyticsScreen()));
          },
        ),
        _buildDivider(),
        _buildDrawerItem(
          context,
          icon: Icons.qr_code_scanner_rounded,
          title: qr_scanner,
         onTap: () {
        Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const TicketScanningScreen(fromDrawer: true),
              ),
            );

          },
        ),
        _buildDivider(),
        _buildDrawerItem(
          context,
          icon: Icons.settings_outlined,
          title: settings,
          onTap: () {
            // Add logout logic
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => SettingsScreen()));
          },
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 17, 0),
      child: Divider(
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      hoverColor: Colors.white.withOpacity(0.1),
      selectedTileColor: Colors.white.withOpacity(0.1),
    );
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
        LogOutButton(),
          const SizedBox(height: 8),
          Text(
            version_txt,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

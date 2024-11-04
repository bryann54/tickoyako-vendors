import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';

class ProfileOptionsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withOpacity(.1),
        border: Border.all(color: AppColors.backgroundDark.withOpacity(.2)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ProfileOptionItem(
            icon: Icons.person,
            title: "Edit Profile",
            onTap: () {},
          ),
          const Divider(),
          ProfileOptionItem(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {},
          ),
          const Divider(),
          ProfileOptionItem(
            icon: Icons.notifications,
            title: "Notification Settings",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProfileOptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accentColor),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}

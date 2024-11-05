import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';
import 'package:tickoyakovendors/core/strings.dart';
import 'package:tickoyakovendors/core/theme/theme_toggle_switch.dart';
import 'package:tickoyakovendors/features/home_screen/presentation/widgets/custom_drawer_widget.dart';
import 'package:tickoyakovendors/features/settings/presentation/widgets/settings_options_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: AnimatedBackgroundWidget(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              stretch: true,
              backgroundColor: AppColors.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [AppColors.accentColor, Colors.white],
                      ).createShader(bounds),
                      child: const Text(
                        settings,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.8),
                        AppColors.secondaryColor,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
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
                        bottom: -20,
                        left: -20,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                 
                       borderRadius: BorderRadius.circular(20),
                      child: Container(
                            decoration: BoxDecoration(
                          color: AppColors.backgroundDark.withOpacity(.1),
                          border: Border.all(
                              color: AppColors.backgroundDark.withOpacity(.2)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Toggle Dark Mode:',
                                style: TextStyle(fontSize: 18),
                              ),
                              ThemeToggle(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SettingsOptionsWidget(),
                    const SizedBox(height: 16),
                     SettingsOptionsWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

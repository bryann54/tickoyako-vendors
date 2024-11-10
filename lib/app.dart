import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickoyakovendors/core/theme/app_theme.dart';
import 'package:tickoyakovendors/core/theme/theme_controller.dart';
import 'package:tickoyakovendors/features/analytics/data/repositories/analytics_repository.dart';
import 'package:tickoyakovendors/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:tickoyakovendors/features/auth/presentation/pages/splash_screen.dart';
import 'package:tickoyakovendors/features/events/data/repositories/events_repository.dart';
import 'package:tickoyakovendors/features/events/presentation/bloc/events_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EventsBloc>(
          create: (context) => EventsBloc(
            EventsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => AnalyticsBloc(
            repository: AnalyticsRepositoryImpl(),
          ),
        )
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeController(),
        child: Consumer<ThemeController>(
          builder: (context, themeController, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'TickoYako Vendors',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeController.themeMode,
              home: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}

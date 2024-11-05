import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';
import 'package:tickoyakovendors/core/strings.dart';
import 'package:tickoyakovendors/features/events/data/repositories/events_repository.dart';
import 'package:tickoyakovendors/features/events/presentation/bloc/events_bloc.dart';
import 'package:tickoyakovendors/features/events/presentation/pages/event_list.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/add_event_dialog_widget.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/custom_fab_widget.dart';
import 'package:tickoyakovendors/features/home_screen/presentation/widgets/custom_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final _eventsRepository = EventsRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<EventsBloc>().add(FetchEvents());
  }

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
                        colors: [
                          AppColors.accentColor,
                          Colors.white,
                        ],
                      ).createShader(bounds),
                      child: const Text(
                        events_txt,
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
                icon: const Icon(Icons.menu, color: Colors.white, size: 35),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 
                    BlocBuilder<EventsBloc, EventsState>(
                      builder: (context, state) {
                        if (state is EventsLoading) {
                          return const Column(
                            children: [
                              SizedBox(
                                height: 300,
                              ),
                              Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            ],
                          );
                        } else if (state is EventsLoaded) {
                          if (state.events.isEmpty) {
                            // Show "No events yet" message if events list is empty
                            return const Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                ),
                                Center(
                                  child: Text(
                                    no_events,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Display list of events
                            return EventsList(events: state.events);
                          }
                        } else if (state is EventsError) {
                          return Center(
                            child: Text(
                              'Error: ${state.message}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomFAB(
        repository: _eventsRepository,
    onPressed: () async {
        final result = await showDialog<Map<String, dynamic>>(
          context: context,
          builder: (BuildContext context) => const AddEventDialog(),
        );

        if (result != null) {
          // Use the event object
        }
      }
      ),
    );
  }
}

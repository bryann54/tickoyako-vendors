import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';
import 'package:tickoyakovendors/core/strings.dart';
import 'package:tickoyakovendors/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:tickoyakovendors/features/home_screen/presentation/widgets/custom_drawer_widget.dart';
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<AnalyticsBloc>().add(FetchAnalyticsData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: AnimatedBackgroundWidget(
        child: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(),
                _buildAnalyticsContent(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return
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
                        analytics,
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
            );
        
  }

  Widget _buildAnalyticsContent(AnalyticsState state) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state is AnalyticsLoading)
              const Center(child: CircularProgressIndicator())
            else if (state is AnalyticsError)
              _buildErrorWidget(state.message)
            else if (state is AnalyticsLoaded)
              _buildAnalyticsCards(state.analyticsData)
            else
              const Center(child: Text('No data available')),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCards(Map<String, dynamic> data) {
    return Column(
      children: [
        _buildSummaryCards(data),
        const SizedBox(height: 20),
        _buildRevenueChart(data),
        const SizedBox(height: 20),
        _buildEventsList(data),
      ],
    );
  }

  Widget _buildSummaryCards(Map<String, dynamic> data) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _analyticsCard(
          'Total Events',
          data['totalEvents']?.toString() ?? '0',
          Icons.event,
          AppColors.accentColor,
        ),
        _analyticsCard(
          'Total Revenue',
          '\$${data['totalRevenue']?.toString() ?? '0'}',
          Icons.monetization_on,
          Colors.green,
        ),
        _analyticsCard(
          'Tickets Sold',
          data['ticketsSold']?.toString() ?? '0',
          Icons.confirmation_number,
          Colors.orange,
        ),
        _analyticsCard(
          'Active Events',
          data['activeEvents']?.toString() ?? '0',
          Icons.event_available,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _analyticsCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(Map<String, dynamic> data) {
    // Implement your chart widget here using fl_chart or any other chart library
    return const Card(
      child: SizedBox(
        height: 200,
        child: Center(
          child: Text('Revenue Chart'),
        ),
      ),
    );
  }

Widget _buildEventsList(Map<String, dynamic> data) {
    return Card(
      // elevation: 1,
      // margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
      child: ListView.separated(
        separatorBuilder: 
        (context, index) => const Divider(height: 1, thickness: 1),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (data['recentEvents'] as List?)?.length ?? 0,
        itemBuilder: (context, index) {
          final event = data['recentEvents'][index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image Container
                  ClipRRect(
                    // borderRadius: const BorderRadius.only(
                    //   topLeft: Radius.circular(12),
                    //   bottomLeft: Radius.circular(12),
                    // ),
                    child: Container(
                      width: 150,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.cardColorDark.withOpacity(.1),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12 + 10 * (index % 2)),
                          bottomRight: Radius.circular(12 + 10 * (index % 2)),
                        ),
                      ),
                      child: Image.network(
                        event['image'] ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Event Details Container
                  Expanded(
                    child: AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(seconds: 4),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.cardColorDark.withOpacity(.1),
                              borderRadius: BorderRadius.only(
                                topRight: 
                                Radius.circular(12 + 10 * (index % 2)),
                                bottomRight: Radius.circular(12 + 10 * (index % 2)),
                              
                              ),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Event Name
                                Text(
                                  event['name'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          const Divider(color: AppColors.dividerColor,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      event['date'] ?? '',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                          const Divider(
                                  color: AppColors.dividerColor,
                                ),
                          
                                // Revenue
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.monetization_on,
                                            size: 16,
                                            color: AppColors.primaryColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '\KSh ${event['revenue'] ?? '0'}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                          
                                    // Status Indicator
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(event['status'])
                                            .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        event['status'] ?? 'N/A',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor(event['status']),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// Helper method to determine status color
  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'upcoming':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<AnalyticsBloc>().add(FetchAnalyticsData());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

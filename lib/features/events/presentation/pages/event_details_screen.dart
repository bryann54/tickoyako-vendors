import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';
import 'package:tickoyakovendors/features/events/data/models/event_model.dart';
import 'package:tickoyakovendors/features/ticket_scanning/presentation/pages/ticket_scanning.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventsModel event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey.shade200,
      body: AnimatedBackgroundWidget(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 400,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'event-image-${widget.event.id}',
                  child: Image.network(
                    widget.event.imgUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.error,
                        size: 40,
                      );
                    },
                  ),
                ),
              ),

              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.arrow_back, color: AppColors.primaryColor),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SliverToBoxAdapter(
              child: Transform.translate(
                offset: const Offset(0, -30),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.white.withOpacity(.6),
                    borderRadius:const BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         const SizedBox(
                          height: 25,
                        ),
                        Hero(
                          tag: 'event-title-${widget.event.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               
                                Text(
                                  widget.event.title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    widget.event.type,
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color:
                                    AppColors.backgroundDark.withOpacity(.1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left Column
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoTile(Icons.location_on, 'Venue',
                                        widget.event.venue),
                                    const SizedBox(height: 8),
                                    _buildInfoTile(Icons.calendar_today, 'Date',
                                        _formatDate(widget.event.date)),
                                    const SizedBox(height: 8),
                                    _buildInfoTile(Icons.attach_money, 'Price',
                                        'KES ${widget.event.price}'),
                                  ],
                                ),
                              ),

                              // Divider between columns
                              Container(
                                height:
                                    100, // Adjusted height to fit content without overflow
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: VerticalDivider(
                                  color: Colors.grey[200],
                                  thickness: 3.0,
                                ),
                              ),

                              // Right Column
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoTile(Icons.phone, 'Contact',
                                        widget.event.contact),
                                    const SizedBox(height: 8),
                                    _buildInfoTile(Icons.person, 'Organizer',
                                        widget.event.eventOwner),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                   const SizedBox(height: 10,),
                        Container(
                             decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                color:
                                    AppColors.backgroundDark.withOpacity(.1)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                              const  Row(
                                  children: [
                                     Text(
                                      'Description',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                    const SizedBox(height: 10),
                                Text(
                                  widget.event.description,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    height: 1.5,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                          const SizedBox(
                          height: 10,
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.primaryColor
                              ),
                              child:const Center(child: Text('Seat map',style: TextStyle(color: AppColors.cardColor,),),),
                            ),
                          ],
                        ),
                       const SizedBox(height: 100,)
                    
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           // Add logout logic
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) =>const TicketScanningScreen()));
        },
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.qr_code),
        label: const Text('Scan Tickets'),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

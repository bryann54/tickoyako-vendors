import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';
import 'package:tickoyakovendors/core/commons/custom_snackbar_widget.dart';
import 'package:tickoyakovendors/features/events/data/models/event_model.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/theater_seating_layout.dart';

class SeatSelectionScreen extends StatefulWidget {
  final EventsModel event;

  const SeatSelectionScreen({Key? key, required this.event}) : super(key: key);

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Set<String> selectedSeats = {};
  Set<String> bookedSeats = {};

  void _onSeatSelected(String seat) {
    setState(() {
      if (selectedSeats.contains(seat)) {
        selectedSeats.remove(seat);
      } else {
        selectedSeats.add(seat);
      }
    });
  }

  void _bookSeats() {
    setState(() {
      bookedSeats.addAll(selectedSeats); // Mark selected seats as booked
      selectedSeats.clear(); // Clear selected seats after booking
    });

    CustomAnimatedSnackbar.show(
      context: context,
      message: 'Booked seats: ${bookedSeats.join(', ')}',
      icon: Icons.check_circle_outline,
      backgroundColor: const Color.fromARGB(190, 0, 0, 0),
    );
  }

  @override
  void dispose() {
    CustomAnimatedSnackbar.dismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Select Seat for the ${widget.event.type} event'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: AnimatedBackgroundWidget(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.withOpacity(0.1),
                Colors.blue.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: TheaterSeatingLayout(
                  onSeatSelected: _onSeatSelected,
                  selectedSeats: selectedSeats,
                  bookedSeats: bookedSeats, // Pass booked seats to layout
                ),
              ),
              if (selectedSeats.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _bookSeats,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      'Book ${selectedSeats.length} Seat(s)',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


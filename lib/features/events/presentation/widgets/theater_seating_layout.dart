import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';

class TheaterSeatingLayout extends StatefulWidget {
  final Function(String) onSeatSelected;
  final Set<String> selectedSeats;
  final Set<String> bookedSeats;

  const TheaterSeatingLayout({
    super.key,
    required this.onSeatSelected,
    required this.selectedSeats,
    required this.bookedSeats,
  });

  @override
  State<TheaterSeatingLayout> createState() => _TheaterSeatingLayoutState();
}

class _TheaterSeatingLayoutState extends State<TheaterSeatingLayout>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      18, // Total number of rows
      (index) => AnimationController(
        duration: Duration(milliseconds: 200 + (index * 100)),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(-1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      ));
    }).toList();

    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildRow(String rowName, int startSeat, int endSeat, int rowIndex) {
    return SlideTransition(
      position: _animations[rowIndex],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(rowName, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          ...List.generate(endSeat - startSeat + 1, (index) {
            final seatNumber = '$rowName-${startSeat + index}';
            final isBooked = widget.bookedSeats.contains(seatNumber);
            final isSelected = widget.selectedSeats.contains(seatNumber);
            final seatColor = isBooked
                ? AppColors.primaryColor
                : isSelected
                    ? Colors.blue
                    : Colors.black38;

            return GestureDetector(
              onTap: isBooked
                  ? null // Disable tapping if seat is booked
                  : () => widget.onSeatSelected(seatNumber),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                margin: const EdgeInsets.all(2),
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: seatColor,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    '${startSeat + index}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }


@override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildHeader('STAGE'),
              const SizedBox(height: 20),
              buildRow('A', 1, 21, 0),
              buildRow('B', 1, 22, 1),
              buildRow('C', 1, 23, 2),
              buildRow('D', 1, 24, 3),
              buildRow('E', 1, 25, 4),
              buildRow('F', 1, 26, 5),
              buildRow('G', 1, 28, 6),
              buildRow('H', 1, 30, 7),
              buildRow('I', 1, 31, 8),
              buildRow('J', 1, 28, 9),
              buildRow('K', 1, 31, 10),
              const SizedBox(height: 20),
              buildRow('L', 1, 14, 11),
              buildRow('M', 1, 10, 12),
              buildRow('N', 1, 8, 13),
              const SizedBox(height: 20),
              buildHeader('BALCONY'),
              const SizedBox(height: 20),
              buildRow('O', 1, 24, 14),
              buildRow('P', 1, 20, 15),
              buildRow('Q', 1, 8, 16),
              buildRow('R', 1, 2, 17),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Key:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Unbooked',
                              style: TextStyle(fontSize: 13)),
                          const Text('Seat', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color:AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Booked', style: TextStyle(fontSize: 13)),
                          const Text('Seat', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Selected',
                              style: TextStyle(fontSize: 13)),
                          const Text('Seat', style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildHeader(String text) {
    return Container(
      height: 40,
      width: 500,
      decoration: const BoxDecoration(color: Colors.black87),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: text == 'STAGE' ? 24 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

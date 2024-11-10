import 'package:flutter/material.dart';
import 'package:tickoyakovendors/features/profile/presentation/widgets/stattic_item_widget.dart';

class ProfileStatisticsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileStatisticItem(
              icon: Icons.check_circle,
              label: "Scanned Tickets",
              count: "123",
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: VerticalDivider(
                color: Colors.grey[200],
                thickness: 2.0,
              ),
            ),
            ProfileStatisticItem(
              icon: Icons.event,
              label: "Events Attended",
              count: "5",
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: VerticalDivider(
                color: Colors.grey[200],
                thickness: 2.0,
              ),
            ),
            ProfileStatisticItem(
              icon: Icons.star,
              label: "Favorites",
              count: "12",
            ),
          ],
        ),
      ),
    );
  }
}

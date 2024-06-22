import 'package:flutter/material.dart';

import '../data/project_model.dart';

class OffersItemWidget extends StatelessWidget {
  final Offers offers;

  const OffersItemWidget({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              offers.status == 'Rejected' ? Icons.close : Icons.check,
              color: offers.status == 'Rejected' ? Colors.red : Colors.green,
              size: 30,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offers.message ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Status: ${offers.status}',
                    style: TextStyle(
                      fontSize: 14,
                      color: offers.status == 'Rejected'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
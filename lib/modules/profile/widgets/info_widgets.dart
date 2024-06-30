import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';

class InfoWidget extends StatelessWidget {
  final String title;
  final IconData icon;

  const InfoWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FlipInY(
      duration: const Duration(milliseconds: 1500),
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Color(0xFF33cccccc),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 16,
            ),
            Icon(icon),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(overflow: TextOverflow.fade),
                // maxLines: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

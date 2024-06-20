import 'package:flutter/cupertino.dart';

class CustomDrawerListTile extends StatelessWidget {
  const CustomDrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: onTap,
      leading: Icon(icon),
    );
  }
}

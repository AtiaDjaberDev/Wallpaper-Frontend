import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({required this.title, this.actions, Key? key}) : super(key: key);

  final String title;
  List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

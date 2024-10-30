import 'package:flutter/material.dart';

class DrawerText extends StatefulWidget {
  final String title;
  final Color textColor;
  final Color borderColor;
  final Color iconColor;
  final IconData icons;
  const DrawerText(
      {super.key,
      required this.title,
      required this.icons,
      required this.iconColor,
      required this.textColor,
      required this.borderColor});

  @override
  State<DrawerText> createState() => _DrawerTextState();
}

class _DrawerTextState extends State<DrawerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: widget.borderColor.withOpacity(0.5),
              offset: const Offset(0, 3),
              blurRadius: 0.3,
              spreadRadius: 0.1)
        ],
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Icon(
            widget.icons,
            color: widget.iconColor,
          ),
          const SizedBox(width: 5),
          FittedBox(
              child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              color: widget.textColor,
            ),
          )),
        ],
      ),
    );
  }
}

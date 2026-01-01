import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SelectionPopup extends StatelessWidget {
  final Offset position;
  final VoidCallback onTap;

  const SelectionPopup({
    super.key,
    required this.position,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF00BCD4)],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2196F3).withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.sparkles, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

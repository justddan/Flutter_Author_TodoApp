import 'package:flutter/material.dart';

class CommonTab extends StatelessWidget {
  final String title;
  const CommonTab({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(.1),
      ),
      child: Tab(
        text: title,
      ),
    );
  }
}

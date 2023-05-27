import 'package:flutter/material.dart';

class TopMenuButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color onHoverColor;
  final VoidCallback onTap;
  final double fontSize;

  const TopMenuButton({
    super.key,
    required this.title,
    required this.icon,
    this.onHoverColor = Colors.blueGrey,
    required this.onTap,
    this.fontSize = 13,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        hoverColor: onHoverColor,
        onTap: onTap,
        child: SizedBox(
          width: 80,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

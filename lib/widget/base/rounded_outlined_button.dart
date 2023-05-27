import 'package:flutter/material.dart';

class RoundedOutlinedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color borderColor;
  final Color textColor;
  final String text;
  final Color backgroundColor;
  final double? width;

  const RoundedOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.borderColor,
    required this.textColor,
    required this.text,
    this.backgroundColor = Colors.black38,
    this.width,
  }) : super(key: key);

  @override
  State<RoundedOutlinedButton> createState() => _RoundedOutlinedButtonState();
}

class _RoundedOutlinedButtonState extends State<RoundedOutlinedButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: OutlinedButton(
        onPressed: widget.onPressed,
        onHover: (val) => setState(() => hover = val),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            hover ? widget.borderColor : widget.backgroundColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          side: MaterialStateProperty.all(
            BorderSide(
              color: widget.borderColor,
            ),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(color: hover ? Colors.white : widget.textColor),
        ),
      ),
    );
  }
}

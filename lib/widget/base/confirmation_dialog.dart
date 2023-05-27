import 'package:fast_downloader/widget/base/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirmPressed;
  final String title;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirmPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
      content: Container(
        color: const Color.fromRGBO(25, 25, 25, 1),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedOutlinedButton(
                text: "No",
                textColor: Colors.red,
                borderColor: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 15,
              ),
              RoundedOutlinedButton(
                text: "Yes",
                textColor: Colors.green,
                borderColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirmPressed();
                },
              ),
            ],
          ),
        )
      ],
      
    );
  }
}

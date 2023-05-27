import 'package:fast_downloader/db/hive_boxes.dart';
import 'package:fast_downloader/provider/queue_provider.dart';
import 'package:fast_downloader/widget/base/closable_window.dart';
import 'package:fast_downloader/widget/base/error_dialog.dart';
import 'package:fast_downloader/widget/base/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/download_queue.dart';

class CreateQueueWindow extends StatefulWidget {
  const CreateQueueWindow({Key? key}) : super(key: key);

  @override
  State<CreateQueueWindow> createState() => _CreateQueueWindowState();
}

class _CreateQueueWindowState extends State<CreateQueueWindow> {
  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ClosableWindow(
      width: 450,
      height: 200,
      disableCloseButton: true,
      padding: EdgeInsets.only(top: 20),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Queue name : ", style: TextStyle(color: Colors.white)),
              const SizedBox(width: 10),
              SizedBox(
                  width: 240,
                  height: 50,
                  child: TextField(
                    maxLines: 1,
                   cursorColor: Color.fromARGB(255, 247, 247, 247),
                    controller: txtController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      contentPadding: EdgeInsets.all(6),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ))
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedOutlinedButton(
                width: 80,
                onPressed: () => Navigator.of(context).pop(),
                borderColor: Colors.red,
                textColor: Colors.red,
                text: "Cancel",
              ),
              const SizedBox(width: 10),
              RoundedOutlinedButton(
                width: 80,
                onPressed: () => onCreatePressed(context),
                borderColor: Colors.green,
                textColor: Colors.green,
                text: "Save",
              ),
            ],
          )
        ],
      ),
      actions: [],
    );
  }

  void onCreatePressed(BuildContext context) async {
    final provider = Provider.of<QueueProvider>(context, listen: false);
    final box = HiveBoxes.instance.downloadQueueBox;
    final duplicateQueueName = box.values
        .where((queue) => queue.name == txtController.value.text)
        .isNotEmpty;
    if (duplicateQueueName) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          text: "A queue with this name already exists!",
          width: 400,
        ),
      );
    } else {
      final queue = DownloadQueue(name: txtController.value.text);
      await provider.saveQueue(queue);
      Navigator.of(context).pop();
    }
  }
}

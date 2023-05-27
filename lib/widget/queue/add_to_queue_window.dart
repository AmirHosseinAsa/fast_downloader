import 'package:fast_downloader/db/hive_boxes.dart';
import 'package:fast_downloader/provider/pluto_grid_util.dart';
import 'package:fast_downloader/widget/base/closable_window.dart';
import 'package:fast_downloader/widget/base/rounded_outlined_button.dart';
import 'package:flutter/material.dart';
import '../../model/download_queue.dart';

class AddToQueueWindow extends StatefulWidget {
  const AddToQueueWindow({Key? key}) : super(key: key);

  @override
  State<AddToQueueWindow> createState() => _AddToQueueWindowState();
}

class _AddToQueueWindowState extends State<AddToQueueWindow> {
  List<DownloadQueue>? downloadQueues = [];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    setDownloadQueues();
    return ClosableWindow(
      width: 300,
      height: 250,
      disableCloseButton: true,
      padding: EdgeInsets.only(top: 50),
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Select Queue : ", style: TextStyle(color: Colors.white)),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: DropdownButton<String>(
                  value: selectedValue,
                  dropdownColor: Colors.black87,
                  menuMaxHeight: 200,
                  items: downloadQueues?.map((DownloadQueue value) {
                    return DropdownMenuItem<String>(
                      value: value.name,
                      child: SizedBox(
                          width: 100,
                          child: Text(value.name,
                              style: const TextStyle(color: Colors.white))),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => selectedValue = value),
                ),
              )
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
                onPressed: onAddPressed,
                borderColor: Colors.green,
                textColor: Colors.green,
                text: "Add",
              ),
            ],
          )
        ],
      ),
      actions: [],
    );
  }

  void onAddPressed() async {
    final selectedQueue =
        downloadQueues?.where((queue) => queue.name == selectedValue).first;
    final selectedRows = PlutoGridUtil.plutoStateManager?.checkedRows;
    if (selectedQueue == null || selectedRows == null) return;
    final queue = HiveBoxes.instance.downloadQueueBox.get(selectedQueue.key)!;
    for (var row in selectedRows) {
      final id = row.cells["id"]!.value;
      queue.downloadItemsIds ??= [];
      if (queue.downloadItemsIds!.any((item) => item == id)) continue;
      queue.downloadItemsIds = [...queue.downloadItemsIds!];
      queue.downloadItemsIds!.add(id);
      HiveBoxes.instance.downloadQueueBox.put(queue.key, queue);
    }
    Navigator.of(context).pop();
  }

  void setDownloadQueues() {
    setState(() {
      downloadQueues = HiveBoxes.instance.downloadQueueBox.values.toList();
    });
  }
}

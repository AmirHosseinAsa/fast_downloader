import 'package:fast_downloader/util/download_addition_ui_util.dart';
import 'package:fast_downloader/widget/base/rounded_outlined_button.dart';
import 'package:fast_downloader/widget/loader/file_info_loader.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddUrlDialog extends StatefulWidget {
  final bool updateDialog;
  final int? downloadId;

  const AddUrlDialog({super.key, this.updateDialog = false, this.downloadId});

  @override
  State<AddUrlDialog> createState() => _AddUrlDialogState();
}

class _AddUrlDialogState extends State<AddUrlDialog> {
  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: FileInfoLoader(
        onCancelPressed: () => DownloadAdditionUiUtil.cancelRequest(context),
      ),
      child: AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        backgroundColor: const Color.fromRGBO(25, 25, 25, 1),
        title: Text(
            widget.updateDialog ? "Update Download URL" : "Add a Download URL",
            style: const TextStyle(color: Colors.white)),
        content: SizedBox(
          width: 400,
          height: 100,
          child: Row(
            children: [
              SizedBox(
                width: 340,
                child: TextField(
                  maxLines: 1,
                  cursorColor: Color.fromARGB(255, 247, 247, 247),
                  controller: txtController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.paste_rounded, color: Colors.white),
                onPressed: () async {
                  String url = await FlutterClipboard.paste();
                  setState(() => txtController.text = url);
                },
              )
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedOutlinedButton(
                  text: "Cancel",
                  width: 80,
                  borderColor: Colors.red,
                  textColor: Colors.red,
                  onPressed: () => _onCancelPressed(context),
                ),
                SizedBox(width: 15,),
                RoundedOutlinedButton(
                  text: widget.updateDialog ? "Update" : "Add",
                  width: 80,
                  borderColor: Colors.green,
                  textColor: Colors.green,
                  onPressed: () => _onAddPressed(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onCancelPressed(BuildContext context) {
    txtController.text = '';
    Navigator.of(context).pop();
  }

  void _onAddPressed(BuildContext context) {
    final url = txtController.text;
    DownloadAdditionUiUtil.handleDownloadAddition(context, url,
        updateDialog: widget.updateDialog,
        downloadId: widget.downloadId,
        additionalPop: true);
  }
}


import 'package:fast_downloader/widget/queue/create_queue_window.dart';
import 'package:fast_downloader/widget/top_menu/top_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/download_request_provider.dart';

class QueueTopMenu extends StatelessWidget {
  late DownloadRequestProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<DownloadRequestProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.82,
      height: 70,
      color: const Color.fromRGBO(46, 54, 67, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TopMenuButton(
              onTap: () => onCreateQueuePressed(context),
              title: 'Create Queue',
              fontSize: 11.5,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              onHoverColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  void onCreateQueuePressed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CreateQueueWindow(),
    );
  }
}

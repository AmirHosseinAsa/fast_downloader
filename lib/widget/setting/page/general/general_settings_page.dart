import 'package:fast_downloader/provider/settings_provider.dart';
import 'package:fast_downloader/widget/setting/page/general/behaviour_settings_group.dart';
import 'package:fast_downloader/widget/setting/page/general/notification_settings_group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            NotificationSettingsGroup(),
            BehaviourSettingsGroup(),
          ],
        ),
      ),
    );
  }
}

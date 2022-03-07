import 'dart:io';

import 'package:ch5_practical/core/widgets/platform_alert_dialog.dart';
import 'package:ch5_practical/features/settings_app_permission/presentation/mobx/switch_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SettingsBarPage extends StatefulWidget {
  const SettingsBarPage({Key? key}) : super(key: key);

  @override
  State<SettingsBarPage> createState() => _SettingsBarPageState();
}

class _SettingsBarPageState extends State<SettingsBarPage> {
  @override
  void didChangeDependencies() {
    context.read<SwitchStore>().checkPermissionStatus();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 32,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Divider(thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(fontSize: 18),
                ),
                Observer(
                  builder: (_) => Switch.adaptive(
                    activeColor: Colors.black,
                    value: context.watch<SwitchStore>().locationSwitchState,
                    onChanged: (value) async {
                      PermissionStatus? _permissionStatus = await context
                          .read<SwitchStore>()
                          .getPermissionState(value);
                      if (_permissionStatus != null) {
                        await showDialog<bool>(
                          context: context,
                          builder: (_) => PlatformAlertDialog(
                            showIOSDialog: Platform.isIOS,
                            title: const Text('Critical Permission'),
                            description: const Text(
                              'Access to your location is crucial for proper functioning of this app. '
                              'Please consider manually changing the access in the settings.',
                            ),
                            positiveText: const Text('Settings'),
                            action: openAppSettings,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Divider(thickness: 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'About the App',
                  style: TextStyle(fontSize: 18),
                ),
                Icon(Icons.arrow_forward_ios_sharp),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(thickness: 1),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(thickness: 1),
            ),
            Text(
              'Login',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(thickness: 1),
            ),
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../utilities.dart';

class AndroidTabBarPage extends StatelessWidget {
  const AndroidTabBarPage({Key? key}) : super(key: key);

  Future<SampleDialogOptions?> _buildDialogOptions(BuildContext context) async {
    return await showDialog<SampleDialogOptions>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('SimpleDialog Title'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(
                context,
                SampleDialogOptions.option1,
              ),
              child: const Text('Option 1'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(
                context,
                SampleDialogOptions.option2,
              ),
              child: const Text('Option 2'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _buildSimpleDialog(BuildContext context) async {
    late String _selectedOption;
    switch (await _buildDialogOptions(context)) {
      case SampleDialogOptions.option1:
        {
          _selectedOption = SampleDialogOptions.option1.value;
          break;
        }
      case SampleDialogOptions.option2:
        {
          _selectedOption = SampleDialogOptions.option2.value;
          break;
        }
      default:
        _selectedOption = 'Nothing Selected';
    }
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(_selectedOption),
        ),
      );
  }

  Future<void> _buildAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('Sample content of Android AlertDialog'),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay!'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  PersistentBottomSheetController<void> _buildBottomSheet(
      BuildContext context) {
    return showBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.symmetric(vertical: 24),
          color: Theme.of(context).colorScheme.secondary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Text(
                  'Android BottomSheet',
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _buildAlertDialog(context),
          child: const Text('AlertDialog'),
        ),
        ElevatedButton(
          onPressed: () => _buildSimpleDialog(context),
          child: const Text('SimpleDialog'),
        ),
        ElevatedButton(
          onPressed: () => _buildBottomSheet(context),
          child: const Text('BottomSheet'),
        ),
      ],
    );
  }
}

import 'package:ch5_practical/extensions.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSTabBarPage extends StatelessWidget {
  const IOSTabBarPage({Key? key}) : super(key: key);

  Future<void> _buildAlertDialog(BuildContext context) async {
    return showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('Sample content of iOS AlertDialog'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Okay!'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Future<SampleDialogOptions?> _buildActionSheet(BuildContext context) {
    return showCupertinoModalPopup<SampleDialogOptions>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: const Text('Cupertino ActionSheet'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Option 1'),
                onPressed: () =>
                    Navigator.pop(context, SampleDialogOptions.option1),
              ),
              CupertinoDialogAction(
                child: const Text('Option 2'),
                onPressed: () =>
                    Navigator.pop(context, SampleDialogOptions.option2),
              ),
            ],
            cancelButton: CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          );
        });
  }

  Future<SampleDialogOptions?> _buildActionSheetSelector(
      BuildContext context) async {
    late String _selectedOption;
    switch (await _buildActionSheet(context)) {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CupertinoButton.filled(
            onPressed: () => _buildAlertDialog(context),
            child: const Text('CupertinoAlertDialog'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CupertinoButton.filled(
            onPressed: () => _buildActionSheetSelector(context),
            child: const Text('CupertinoActionSheet'),
          ),
        ),
      ],
    );
  }
}

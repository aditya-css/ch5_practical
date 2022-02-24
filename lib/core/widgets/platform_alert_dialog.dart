import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends StatelessWidget {
  const PlatformAlertDialog({
    Key? key,
    required this.showIOSDialog,
    this.title = const Text('AlertDialog Title'),
    required this.description,
    this.positiveText = const Text('Okay!'),
    this.negativeText,
    this.action,
  }) : super(key: key);

  final VoidCallback? action;
  final Text? negativeText;
  final bool showIOSDialog;
  final Text title, description, positiveText;

  @override
  Widget build(BuildContext context) {
    return (showIOSDialog)
        ? CupertinoAlertDialog(
            title: title,
            content: description,
            actions: <CupertinoDialogAction>[
              if (negativeText != null)
                CupertinoDialogAction(
                  child: negativeText!,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: positiveText,
                onPressed: () {
                  if (action != null) {
                    action!();
                  }
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          )
        : AlertDialog(
            title: title,
            content: description,
            actions: <TextButton>[
              if (negativeText != null)
                TextButton(
                  child: negativeText!,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              TextButton(
                child: positiveText,
                onPressed: () {
                  if (action != null) {
                    action!();
                  }
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
  }
}

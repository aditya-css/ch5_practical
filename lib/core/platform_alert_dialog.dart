import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAlertDialog extends StatelessWidget {
  const PlatformAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.positiveText,
    this.negativeText,
  }) : super(key: key);

  final Text title, description, positiveText;
  final Text? negativeText;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: title,
            content: description,
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: positiveText,
                onPressed: () => Navigator.of(context).pop(true),
              ),
              if (negativeText != null)
                CupertinoDialogAction(
                  child: negativeText!,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
            ],
          )
        : AlertDialog(
            title: title,
            content: description,
            actions: <TextButton>[
              TextButton(
                child: positiveText,
                onPressed: () => Navigator.of(context).pop(true),
              ),
              if (negativeText != null)
                TextButton(
                  child: negativeText!,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
            ],
          );
  }
}

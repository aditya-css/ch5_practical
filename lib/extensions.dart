import 'package:ch5_practical/utilities.dart';
import 'package:intl/intl.dart' show DateFormat;

extension SimpleDialogOptionsExtension on SampleDialogOptions {
  String get value {
    switch (this) {
      case SampleDialogOptions.option1:
        return 'Sample Option 1';
      case SampleDialogOptions.option2:
        return 'Sample Option 2';
    }
  }
}

extension TimeAgo on String {
  String get calculate {
    String date = this;
    DateTime _formattedDate = DateFormat("dd-MM-yyyy").parse(date);
    Duration _diff = DateTime.now().difference(_formattedDate);
    if (_diff.inDays > 365) {
      return "${(_diff.inDays / 365).floor()} ${(_diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (_diff.inDays > 30) {
      return "${(_diff.inDays / 30).floor()} ${(_diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (_diff.inDays > 7) {
      return "${(_diff.inDays / 7).floor()} ${(_diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (_diff.inDays > 0) {
      return "${_diff.inDays} ${_diff.inDays == 1 ? "day" : "days"} ago";
    }
    return "just now";
  }
}

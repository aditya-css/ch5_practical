import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

part 'switch_store.g.dart';

class SwitchStore = _SwitchStore with _$SwitchStore;

abstract class _SwitchStore with Store {
  @readonly
  bool _switchStateValue = false;

  @action
  Future<void> checkPermissionStatus() async =>
      _switchStateValue = await Permission.location.isGranted;

  @action
  Future<PermissionStatus?> getPermissionState(bool newState) async {
    if (newState == false) {
      return PermissionStatus.denied;
    }
    final PermissionStatus _status = await Permission.location.request();
    switch (_status) {
      case PermissionStatus.granted:
        _switchStateValue = true;
        break;
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return _status;
      default:
        _switchStateValue = false;
    }
    return null;
  }
}

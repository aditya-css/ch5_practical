import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';

part 'switch_store.g.dart';

class SwitchStore = _SwitchStore with _$SwitchStore;

abstract class _SwitchStore with Store {
  @readonly
  bool _locationSwitchState = false;

  @action
  Future<void> checkPermissionStatus() async =>
      _locationSwitchState = await Permission.location.isGranted;

  @action
  Future<PermissionStatus?> getPermissionState(bool newState) async {
    if (newState == false) {
      return PermissionStatus.denied;
    }
    final PermissionStatus _status = await Permission.location.request();
    switch (_status) {
      case PermissionStatus.granted:
        _locationSwitchState = true;
        break;
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return _status;
      default:
        _locationSwitchState = false;
    }
    return null;
  }
}

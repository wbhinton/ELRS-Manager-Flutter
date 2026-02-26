import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'persistence_service.g.dart';

class PersistenceService {
  final SharedPreferences _prefs;

  PersistenceService(this._prefs);

  static const _keyBindPhrase = 'flashing_bind_phrase';
  static const _keyWifiSsid = 'flashing_wifi_ssid';
  static const _keyWifiPassword = 'flashing_wifi_password';
  static const _keyManualIp = 'manual_ip';
  static const _keyDisclaimerAccepted = 'disclaimer_accepted';

  Future<void> saveManualIp(String ip) async {
    await _prefs.setString(_keyManualIp, ip);
  }

  String? loadManualIp() {
    return _prefs.getString(_keyManualIp);
  }

  Future<void> setBindPhrase(String value) async {
    await _prefs.setString(_keyBindPhrase, value);
  }

  String getBindPhrase() {
    return _prefs.getString(_keyBindPhrase) ?? '';
  }

  Future<void> setWifiSsid(String value) async {
    await _prefs.setString(_keyWifiSsid, value);
  }

  String getWifiSsid() {
    return _prefs.getString(_keyWifiSsid) ?? '';
  }

  Future<void> setWifiPassword(String value) async {
    await _prefs.setString(_keyWifiPassword, value);
  }

  String getWifiPassword() {
    return _prefs.getString(_keyWifiPassword) ?? '';
  }

  bool hasAcceptedDisclaimer() {
    return _prefs.getBool(_keyDisclaimerAccepted) ?? false;
  }

  Future<void> setDisclaimerAccepted() async {
    await _prefs.setBool(_keyDisclaimerAccepted, true);
  }
}

@riverpod
Future<PersistenceService> persistenceService(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return PersistenceService(prefs);
}

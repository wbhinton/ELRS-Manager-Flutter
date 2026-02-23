import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/core/storage/persistence_service.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';

// 1. Mock Service
class MockPersistenceService implements PersistenceService {
  final Map<String, String> _storage = {};

  @override
  Future<void> setBindPhrase(String value) async {
    _storage['bindPhrase'] = value;
  }

  @override
  String getBindPhrase() => _storage['bindPhrase'] ?? '';

  @override
  Future<void> setWifiSsid(String value) async {
    _storage['wifiSsid'] = value;
  }

  @override
  String getWifiSsid() => _storage['wifiSsid'] ?? '';

  @override
  Future<void> setWifiPassword(String value) async {
    _storage['wifiPassword'] = value;
  }

  @override
  String getWifiPassword() => _storage['wifiPassword'] ?? '';

  @override
  Future<void> setRegulatoryDomain(int value) async {
    _storage['regulatoryDomain'] = value.toString();
  }

  @override
  int getRegulatoryDomain() => int.parse(_storage['regulatoryDomain'] ?? '0');

  @override
  Future<void> saveManualIp(String ip) async {
    _storage['manualIp'] = ip;
  }

  @override
  String? loadManualIp() => _storage['manualIp'];
}

void main() {
  test('Controller loads saved options on init', () async {
    // 2. Setup
    final mockStorage = MockPersistenceService();
    // Preload mock data
    await mockStorage.setBindPhrase('test_phrase');
    await mockStorage.setWifiSsid('My_WiFi');
    await mockStorage.setWifiPassword('secret_password');
    await mockStorage.setRegulatoryDomain(1);

    final container = ProviderContainer(
      overrides: [
        persistenceServiceProvider.overrideWith((ref) => Future.value(mockStorage)),
      ],
    );
    addTearDown(container.dispose);

    // Act
    await container.read(flashingControllerProvider.notifier).loadSavedOptions();
    final state = container.read(flashingControllerProvider);

    // Assert
    expect(state.bindPhrase, equals('test_phrase'));
    expect(state.wifiSsid, equals('My_WiFi'));
    // Optionally check others
    expect(state.wifiPassword, equals('secret_password'));
    expect(state.regulatoryDomain, equals(1));
  });

  test('Controller updates state when user types and persists', () async {
    // 3. Setup
    final mockStorage = MockPersistenceService();
    final container = ProviderContainer(
      overrides: [
        persistenceServiceProvider.overrideWith((ref) => Future.value(mockStorage)),
      ],
    );
    addTearDown(container.dispose);

    // Act
    final subscription = container.listen(flashingControllerProvider, (_, __) {});
    await container.read(flashingControllerProvider.notifier).setBindPhrase('new_secret');
    
    // Assert State
    final state = container.read(flashingControllerProvider);
    expect(state.bindPhrase, equals('new_secret'));

    // Assert Persistence (wait slightly for async save if needed, but the mock is synchronous-ish inside Future)
    // The controller calls _saveOptions which calls await storage.saveOptions.
    // Since we didn't await the setBindPhrase (it's void), we might race.
    // But typically un-awaited Futures in tests might need pumping or simple delay.
    // However, MockSecureStorageService methods are async? Yes, Future<void>.
    // So `setBindPhrase` starts a future "fire and forget".
    
    // To properly verify async side-effects that are fire-and-forget, we need to ensure the event loop processes it.
    await Future.delayed(Duration.zero);
    
    final loaded = mockStorage.getBindPhrase();
    expect(loaded, equals('new_secret'));
  });
}

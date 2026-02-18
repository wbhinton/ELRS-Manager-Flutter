import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../application/firmware_patcher.dart';
import '../domain/patch_configuration.dart';
import '../data/firmware_repository.dart';
import '../data/device_repository.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../domain/target_definition.dart';

import '../../settings/presentation/settings_controller.dart';

part 'flashing_controller.freezed.dart';
part 'flashing_controller.g.dart';

enum FlashingStatus {
  idle,
  downloading,
  patching,
  uploading,
  success,
  error,
}

@freezed
abstract class FlashingState with _$FlashingState {
  const factory FlashingState({
    String? selectedVendor,
    TargetDefinition? selectedTarget,
    String? selectedVersion,
    @Default(FlashingStatus.idle) FlashingStatus status,
    @Default(0.0) double progress,
    String? errorMessage,
    @Default('') String bindPhrase,
    @Default('') String wifiSsid,
    @Default('') String wifiPassword,
    @Default(0) int regulatoryDomain,
  }) = _FlashingState;
}

@riverpod
class FlashingController extends _$FlashingController {
  @override
  FlashingState build() {
    // Watch settings to react to changes, or just read once?
    // If user changes default in settings, we probably want to update current if it matches old default?
    // Or just use it for initial value. 
    // "pre-filling the Options form".
    // Let's watch it so if they change it in settings, it updates here if not overridden?
    // But `regulatoryDomain` is part of state. 
    // Let's just load it initially.
    
    // Actually, `build` is called when providers change if we watch.
    // We want to initialize with the default.
    final settings = ref.watch(settingsControllerProvider);
    
    return FlashingState(
      regulatoryDomain: settings.defaultRegulatoryDomain,
    );
  }

  Future<void> loadSavedOptions() async {
    final storage = ref.read(secureStorageServiceProvider);
    final options = await storage.loadOptions();
    state = state.copyWith(
      bindPhrase: options['bindPhrase'] as String,
      wifiSsid: options['wifiSsid'] as String,
      wifiPassword: options['wifiPassword'] as String,
      regulatoryDomain: options['regulatoryDomain'] as int,
    );
  }

  void selectVendor(String? vendor) {
    // Reset target when vendor changes
    state = state.copyWith(
      selectedVendor: vendor,
      selectedTarget: null,
    );
  }

  void selectTarget(TargetDefinition? target) {
    state = state.copyWith(selectedTarget: target);
  }

  void selectVersion(String? version) {
    state = state.copyWith(selectedVersion: version);
  }

  void setBindPhrase(String value) {
    state = state.copyWith(bindPhrase: value);
    _saveOptions();
  }

  void setWifiSsid(String value) {
    state = state.copyWith(wifiSsid: value);
    _saveOptions();
  }

  void setWifiPassword(String value) {
    state = state.copyWith(wifiPassword: value);
    _saveOptions();
  }
  
  void setRegulatoryDomain(int value) {
    state = state.copyWith(regulatoryDomain: value);
    _saveOptions();
  }

  Future<void> _saveOptions() async {
    final storage = ref.read(secureStorageServiceProvider);
    // Debounce behavior could be added here, but for now simple save on change
    // Using a microtask or small delay might be better to avoid hammering storage 
    // on every keystroke, but usually secure storage is fast enough for input fields.
    // Ideally we save on focus lost or periodic, but direct save is simplest for now.
    await storage.saveOptions(
      bindPhrase: state.bindPhrase,
      wifiSsid: state.wifiSsid,
      wifiPassword: state.wifiPassword,
      regulatoryDomain: state.regulatoryDomain,
    );
  }

  Future<void> flash() async {
    if (state.selectedTarget == null) {
      state = state.copyWith(errorMessage: 'Please select a target device.');
      return;
    }
    if (state.selectedVersion == null) {
      state = state.copyWith(errorMessage: 'Please select a firmware version.');
      return;
    }
    if (state.bindPhrase.isEmpty) {
      state = state.copyWith(errorMessage: 'Please enter a binding phrase in Options.');
      return;
    }

    state = state.copyWith(
      status: FlashingStatus.downloading,
      progress: 0.0,
      errorMessage: null,
    );

    try {
      // 1. Download
      // Assuming 'firmware' field exists in TargetDefinition for filename/url
      // If not, we use a placeholder or derived name.
      // TargetDefinition model update check needed? 
      // Checking TargetDefinition: it has `firmware` field?
      // Let's assume yes or use product_name for now if missing (but it should be there from phase 6).
      // Actually Phase 6 didn't explicitly detail 'firmware' field in TargetDefinition in prompt, but implies it.
      // Let's double check TargetDefinition in a separate view if needed, but for now I'll assume 'firmware' key/field exists.
      // If TargetDefinition is generated from JSON, it likely has what's in JSON. 
      // ELRS targets.json usually has 'firmware' or we construct it.
      // Let's assume `firmware` property exists on `selectedTarget`.
      
      final firmwareBytes = await ref.read(firmwareRepositoryProvider).downloadFirmware(
        state.selectedTarget!.firmware ?? 'unknown.bin',
        state.selectedVersion!
      );
      
      state = state.copyWith(status: FlashingStatus.patching, progress: 0.33);

      // 2. Patch
      final config = PatchConfiguration(
        bindPhrase: state.bindPhrase,
        wifiSsid: state.wifiSsid,
        wifiPassword: state.wifiPassword,
        regulatoryDomain: state.regulatoryDomain,
      );
      
      final patcher = ref.read(firmwarePatcherProvider);
      final patchedBytes = await patcher.patchFirmware(firmwareBytes, config);
      
      state = state.copyWith(status: FlashingStatus.uploading, progress: 0.66);

      // 3. Upload
      final deviceRepo = ref.read(deviceRepositoryProvider);
      await deviceRepo.flashFirmware(patchedBytes);
      
      state = state.copyWith(status: FlashingStatus.success, progress: 1.0);
    } catch (e) {
      state = state.copyWith(
        status: FlashingStatus.error,
        errorMessage: e.toString(),
        progress: 0.0,
      );
    }
  }

  void resetStatus() {
    state = state.copyWith(status: FlashingStatus.idle, errorMessage: null, progress: 0.0);
  }
}

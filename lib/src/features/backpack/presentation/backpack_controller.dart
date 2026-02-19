import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../backpack/data/backpack_repository.dart';
import '../../flashing/data/device_repository.dart';

part 'backpack_controller.freezed.dart';
part 'backpack_controller.g.dart';

enum BackpackStatus {
  idle,
  downloading,
  flashing,
  success,
  error,
}

@freezed
abstract class BackpackState with _$BackpackState {
  const factory BackpackState({
    String? selectedTarget,
    @Default(BackpackStatus.idle) BackpackStatus status,
    @Default(0.0) double progress,
    String? errorMessage,
    @Default([]) List<String> availableTargets,
  }) = _BackpackState;
}

@riverpod
class BackpackController extends _$BackpackController {
  @override
  BackpackState build() {
    return const BackpackState();
  }

  Future<void> loadTargets() async {
    try {
      final repo = ref.read(backpackRepositoryProvider);
      final targets = await repo.fetchBackpackTargets();
      state = state.copyWith(availableTargets: targets);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to load targets: $e');
    }
  }

  void selectTarget(String? target) {
    state = state.copyWith(selectedTarget: target);
  }

  Future<void> flash() async {
    if (state.selectedTarget == null) {
      state = state.copyWith(errorMessage: 'Please select a module');
      return;
    }

    state = state.copyWith(status: BackpackStatus.downloading, progress: 0.0, errorMessage: null);

    try {
      final backpackRepo = ref.read(backpackRepositoryProvider);
      final deviceRepo = ref.read(deviceRepositoryProvider);

      // 1. Download
      final bytes = await backpackRepo.downloadBackpackFirmware(state.selectedTarget!);
      
      state = state.copyWith(status: BackpackStatus.flashing, progress: 0.5);

      // 2. Flash (Passthrough to VRX via backpack protocol on the TX, typically)
      // Note: The prompt says "Reuse the existing DeviceRepository".
      // In reality, flashing a backpack connected to a TX via the TX wifi might use a different endpoint or specific payload/header.
      // But we will follow instructions to call `deviceRepo.flashFirmware(bytes)`.
      
      final sanitizedFilename = state.selectedTarget!
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_') + '.bin';

      await deviceRepo.flashFirmware(
        bytes, 
        sanitizedFilename,
        onSendProgress: (sent, total) {
           // We could map this to 0.5 -> 1.0 progress
        }
      );

      state = state.copyWith(status: BackpackStatus.success, progress: 1.0);
    } catch (e) {
      state = state.copyWith(
        status: BackpackStatus.error, 
        errorMessage: 'Flash failed: $e',
        progress: 0.0
      );
    }
  }
}

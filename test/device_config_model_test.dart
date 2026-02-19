import 'package:elrs_manager/src/features/configurator/domain/device_config_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceConfig Model', () {
    test('Parses valid /config JSON correctly', () {
      // Setup
      final json = <String, dynamic>{
        "product_name": "BetaFPV Nano RX",
        "version": "3.3.0",
        "uid": [37, 16, 128, 230, 252, 116],
        "pwm_outputs": [0, 1, 2, 3], 
        "reg_domain": "FCC915",
        "modelId": 2,
        "options": {"packet_rate": 50, "telem_ratio": 1}
      };

      // Act
      final model = DeviceConfig.fromJson(json);

      // Assert
      expect(model.productName, 'BetaFPV Nano RX');
      expect(model.version, '3.3.0');
      expect(model.uid, hasLength(6));
      expect(model.uid, equals([37, 16, 128, 230, 252, 116]));
      expect(model.pwmOutputs, equals([0, 1, 2, 3]));
      expect(model.regDomain, 'FCC915');
      expect(model.modelId, 2);
      expect(model.options['packet_rate'], 50);
    });

    test('Handles missing optional fields', () {
      final json = <String, dynamic>{
        // "product_name" missing
        "version": "1.0",
        // "uid" missing
      };

      final model = DeviceConfig.fromJson(json);

      expect(model.productName, null);
      expect(model.version, '1.0');
      expect(model.uid, isEmpty); // Default is []
      expect(model.modelId, 255); // Default
    });
  });
}

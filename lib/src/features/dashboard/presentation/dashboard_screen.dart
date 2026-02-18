import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/connection_status_badge.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ELRS Command'),
        actions: const [
          ConnectionStatusBadge(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          DashboardCard(
            title: 'Flash Device',
            icon: Icons.system_update,
            color: Colors.teal,
            onTap: () => context.push('/flashing'),
          ),
          DashboardCard(
            title: 'PWM Config',
            icon: Icons.tune,
            color: Colors.amber,
            onTap: () => context.push('/pwm_config'),
          ),
          DashboardCard(
            title: 'Backpack',
            icon: Icons.videocam,
            color: Colors.deepPurple,
            onTap: () => context.push('/backpack'),
          ),
          DashboardCard(
            title: 'Settings',
            icon: Icons.settings,
            color: Colors.grey,
            onTap: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}

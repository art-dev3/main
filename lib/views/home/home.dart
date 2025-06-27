import 'package:flutter/material.dart';
import 'package:main/services/json_service.dart';
import 'package:main/views/da_dynamic_ui/views/department_screen.dart';
import 'package:main/views/json_dynamic_widget/api.dart';
import 'package:module_b/module_b_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Choose a Demo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () =>
                      _navigateTo(context, const CreditCardScreen()),
                  icon: const Icon(Icons.credit_card),
                  label: const Text('From GitHub Module B'),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => _navigateTo(context, const DaScreen()),
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Server driven UI '),
                ),
                FilledButton.icon(
                  onPressed: () async {
                    try {
                      final jsonUI = await JsonService.fetchJsonDynamic();
                      _navigateTo(
                        context,
                        DepartmentOfAgricultureScreen(
                          partnerId: "abc123",
                          uiJson: jsonUI
                              .cast<
                                String,
                                dynamic
                              >(), // 👈 ensures Map<String, dynamic>
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to load screen: $e')),
                      );
                    }
                  },
                  icon: const Icon(Icons.cloud_download),
                  label: const Text('Server driven UI'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

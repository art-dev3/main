import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../services/json_service.dart'; // Adjust the path if needed

class APIUI extends StatelessWidget {
  const APIUI({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: JsonService.fetchJson(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return StacApp(
          homeBuilder: (context) => Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child:
                  Stac.fromJson(snapshot.data!, context) ??
                  const Text('Unknown'),
            ),
          ),
        );
      },
    );
  }
}

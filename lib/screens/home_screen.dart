import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set valid API base URL in order to continue',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                Icon(Icons.compare_arrows),
                SizedBox(width: 20),
                Expanded(child: TextField()),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Start counting process'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

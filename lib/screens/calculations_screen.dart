import 'package:flutter/material.dart';

import '../models/app_config_model.dart';
import '../models/calculating_result_model.dart';
import '../services/app_processor.dart';
import '../widgets/custom_elevated_button.dart';
import 'result_list_screen.dart';

class CalculationScreen extends StatefulWidget {
  final List<AppConfigModel> appConfigs;

  const CalculationScreen({super.key, required this.appConfigs});

  @override
  _CalculationScreenState createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  String statusMessage = 'Data processing is in progress';
  bool isProcessing = true;
  List<CalculatingResultModel> processingResults = [];

  @override
  void initState() {
    super.initState();
    _calculateData();
  }

  Future<void> _calculateData() async {
    setState(() {
      statusMessage = 'Data processing is in progress';
      isProcessing = true;
    });

    try {
      final results = AppProcessorService().findShortestPath(widget.appConfigs);
      setState(() {
        processingResults = results;
        statusMessage =
            'All calculations have finished, you can send your results to the server';
        isProcessing = false;
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error processing data';
        isProcessing = false;
      });
    }
  }

  void _submitResults() async {
    setState(() {
      statusMessage = 'Sending results to the server';
      isProcessing = true;
    });

    // Simulate sending results
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      statusMessage = 'Success!';
      isProcessing = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ResultListScreen(processingResults: processingResults),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: false,
        title: Text(
          'Process Screen',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    statusMessage,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: isProcessing ? null : _submitResults,
                  text: 'Send results to server',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

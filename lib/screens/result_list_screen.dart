import 'package:flutter/material.dart';

import '../models/calculating_result_model.dart';
import 'preview_screen.dart';

class ResultListScreen extends StatefulWidget {
  final List<CalculatingResultModel> processingResults;

  const ResultListScreen({super.key, required this.processingResults});

  @override
  _ResultListScreenState createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {
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
          'Result list screen',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _ResultListPageLayout(processingResults: widget.processingResults),
    );
  }
}

class _ResultListPageLayout extends StatelessWidget {
  final List<CalculatingResultModel> processingResults;

  const _ResultListPageLayout({super.key, required this.processingResults});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: processingResults.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewScreen(
                  processingResult: processingResults[index],
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 5,
            ),
            child: Text(
              processingResults[index].result.path,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.grey,
          height: 0,
        );
      },
    );
  }
}

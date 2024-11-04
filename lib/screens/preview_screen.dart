import 'package:flutter/material.dart';

import '../models/calculating_result_model.dart';
import '../models/cell_model.dart';
import '../models/grid_model.dart';

class PreviewScreen extends StatefulWidget {
  final CalculatingResultModel processingResult;

  const PreviewScreen({super.key, required this.processingResult});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
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
          'Preview Screen',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AppGridDisplayWidget(
                appGrid: widget.processingResult.finalCellsGrid),
            SizedBox(height: 15),
            Text(
              widget.processingResult.result.path.toString(),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppGridDisplayWidget extends StatelessWidget {
  final CellsGrid appGrid;

  const _AppGridDisplayWidget({super.key, required this.appGrid});

  @override
  Widget build(BuildContext context) {
    final flatGrid = appGrid.asFlatList;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: appGrid.size,
      ),
      itemCount: flatGrid.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final cell = flatGrid[index];
        return _CellWidget(cell: cell);
      },
    );
  }
}

class _CellWidget extends StatelessWidget {
  final Cell cell;

  const _CellWidget({super.key, required this.cell});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Container(
        decoration: BoxDecoration(
          color: switch (cell.type) {
            CellType.start => Color.fromRGBO(100, 255, 218, 1),
            CellType.end => Color.fromRGBO(0, 150, 136, 1),
            CellType.path => Color.fromRGBO(76, 175, 80, 1),
            CellType.blocked => const Color.fromARGB(255, 0, 0, 0),
            _ => Colors.white,
          },
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            cell.position.toString(),
            style: TextStyle(
              fontSize: 16,
              color:
                  cell.type == CellType.blocked ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

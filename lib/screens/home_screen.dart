import 'package:flutter/material.dart';

import '../models/app_config_model.dart';
import '../repo/app_config_repository.dart';
import '../repo/app_settings.dart';
import '../widgets/custom_elevated_button.dart';
import 'calculations_screen.dart';

class HomeScreen extends StatefulWidget {
  final AppConfigRepository configRepo;
  final AppSettings appSettings;

  const HomeScreen({
    super.key,
    required this.configRepo,
    required this.appSettings,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String apiLinkInput = '';
  String errorMessage = '';
  bool isLoading = false;
  List<AppConfigModel> appConfigs = [];

  @override
  void initState() {
    super.initState();
    _loadApiLinkFromSettings();
  }

  Future<void> _loadApiLinkFromSettings() async {
    var savedApiLink = await widget.appSettings.getApiLink();
    if (savedApiLink != null) {
      setState(() {
        apiLinkInput = savedApiLink;
      });
    }
  }

  Future<void> _getAppConfigs() async {
    setState(() {
      isLoading = true;
    });

    try {
      final configs =
          await widget.configRepo.getAppConfigs(endpoint: apiLinkInput);
      if (configs.isNotEmpty) {
        setState(() {
          appConfigs = configs;
          isLoading = false;
        });
        await widget.appSettings.setApiLink(apiLinkInput);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalculationScreen(appConfigs: appConfigs),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No app configurations found.';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load app configurations.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: false,
        title: Text(
          'Home Screen',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
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
                  Expanded(
                    child: TextField(
                      onChanged: (input) {
                        setState(() {
                          apiLinkInput = input;
                        });
                      },
                      controller: TextEditingController(text: apiLinkInput),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'API URL',
                      ),
                    ),
                  ),
                ],
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      errorMessage,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                ),
              if (isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed: isLoading ? null : _getAppConfigs,
                    text: 'Start counting process',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// lib/screens/name_display_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_edit_screen.dart';

class NameDisplayScreen extends StatefulWidget {
  const NameDisplayScreen({super.key});

  @override
  _NameDisplayScreenState createState() => _NameDisplayScreenState();
}

class _NameDisplayScreenState extends State<NameDisplayScreen> {
  String _firstName = '';
  String _lastName = '';
  bool _forceLandscape = true; // Default to landscape
  final String _orientationKey = 'forceLandscape';

  @override
  void initState() {
    super.initState();
    _loadName();
    _loadOrientation();
  }

  Future<void> _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstName') ?? '';
      _lastName = prefs.getString('lastName') ?? '';
    });
  }

  Future<void> _loadOrientation() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _forceLandscape = prefs.getBool(_orientationKey) ?? true;
      _updateOrientation();
    });
  }

  Future<void> _toggleOrientation() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _forceLandscape = !_forceLandscape;
      prefs.setBool(_orientationKey, _forceLandscape);
      _updateOrientation();
    });
  }

  void _updateOrientation() {
    if (_forceLandscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  void _copyToClipboard() {
    final fullName = '$_firstName $_lastName'.trim();
    if (fullName.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: fullName));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me'),
        actions: [
          IconButton(
            icon: Icon(_forceLandscape
                ? Icons.screen_lock_landscape
                : Icons.screen_lock_portrait),
            onPressed: _toggleOrientation,
            tooltip:
                _forceLandscape ? 'Switch to Portrait' : 'Switch to Landscape',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NameEditScreen(),
                ),
              );
              _loadName();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GestureDetector(
            onDoubleTap: _copyToClipboard,
            child: Text(
              '$_firstName $_lastName',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  dispose() {
    // Reset orientation settings when disposing
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}

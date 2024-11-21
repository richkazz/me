import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'name_display_screen.dart';
import '../widgets/name_input_form.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  Future<void> _saveName() async {
    if (_formKey.currentState!.validate()) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('firstName', _firstNameController.text.trim());
        await prefs.setString('lastName', _lastNameController.text.trim());
        await prefs.setBool('hasCompletedOnboarding', true);

        // Remove focus from text fields
        FocusScope.of(context).unfocus();

        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NameDisplayScreen()),
        );
      } catch (e) {
        // Handle SharedPreferences error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to save data. Please try again.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // Use SingleChildScrollView to prevent overflow
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: OrientationBuilder(
              builder: (context, orientation) {
                return Container(
                  // Add a container for better styling control
                  padding:
                      const EdgeInsets.symmetric(vertical: 48), // Add padding
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(12), // Add rounded corners
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome to Me',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold, // Adjust font weight
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Let\'s get to know you',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey[600], // Adjust text color
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      NameInputForm(
                        formKey: _formKey,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        onSubmit: _saveName,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

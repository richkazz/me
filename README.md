# Me - Personal Name Display App

A minimalist Flutter application that elegantly displays your full name. The app features a clean, modern interface with support for both iOS and Android platforms.

## Features

- 👤 Simple and elegant name display
- 📱 Responsive design (works in both portrait and landscape)
- ✨ Material Design 3 UI
- 💾 Persistent storage using SharedPreferences
- 🚀 First-time user onboarding experience
- ✏️ Easy name editing functionality

## Prerequisites

Before you begin, ensure you have installed:
- Flutter (latest stable version)
- Dart SDK
- Android Studio / Xcode (for iOS development)
- A suitable IDE (VS Code, Android Studio, or IntelliJ IDEA)

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/me_app.git
cd me_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── onboarding_screen.dart
│   ├── name_display_screen.dart
│   └── name_edit_screen.dart
└── widgets/
    └── name_input_form.dart
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
  cupertino_icons: ^1.0.2
```

## Usage

1. First Launch:
   - On first launch, you'll be presented with the onboarding screen
   - Enter your first and last name
   - Submit to proceed to the main display

2. Main Display:
   - Your full name is displayed in a clear, legible format
   - Use the edit button in the app bar to modify your name

3. Edit Name:
   - Tap the edit icon in the app bar
   - Modify your first and/or last name
   - Save to update the display

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Support

For support, please open an issue in the GitHub repository.

## Acknowledgments

- Flutter team for the amazing framework
- Material Design team for the design guidelines
- Contributors and maintainers

## Screenshots

[20241121-233941](https://github.com/user-attachments/assets/9f012cf9-3dc6-4f58-a2cd-9aef3dba5128)
[20241121-233858](https://github.com/user-attachments/assets/48222256-fed2-4265-8eaf-bfc5f6064d4e)
[20241121-233931](https://github.com/user-attachments/assets/c656c63b-24c4-421f-b97a-072110ecfe57)


## Development Notes

- The app uses native Flutter state management without external packages
- Form validation ensures proper name input
- SharedPreferences is used for persistent storage
- OrientationBuilder ensures proper display in both orientations

## Future Enhancements

- Theme customization
- Additional name formatting options
- Localization support
- Dark mode support
- Custom font selection
- Name pronunciation guide
- Export/Import functionality

## Build and Deploy

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

The built applications will be available in their respective build directories.

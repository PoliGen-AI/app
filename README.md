# PoliGen-AI

A Flutter desktop application for AI-powered image generation that runs in the system tray.

## Features

- 🎨 AI-powered image generation
- 🖥️ Cross-platform desktop support (Windows, macOS, Linux)
- 📱 System tray integration with close-to-tray functionality
- 🔔 Native system notifications
- 🎯 Clean, modern UI with Aurora background effects

## Getting Started

### Prerequisites

- Flutter SDK (>=3.8.1)
- Platform-specific development tools:
  - **Windows**: Visual Studio with C++ build tools
  - **macOS**: Xcode
  - **Linux**: Standard build tools

### Installation

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd poligen_app
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run -d windows  # For Windows
   flutter run -d macos    # For macOS
   flutter run -d linux    # For Linux
   ```

## System Tray & Notifications

### Behavior

- **Close to Tray**: Clicking the window X button hides the app to the system tray instead of closing it
- **System Notifications**: A native notification appears when the app is minimized to tray
- **Tray Menu**: Right-click the tray icon for options:
  - "Mostrar Janela" - Restore the window
  - "Configurações" - Open settings (future feature)
  - "Sair" - Completely exit the application

### Testing on Windows

**Important**: Windows notifications may require additional setup for consistent display:

#### **Development Testing**:

```bash
flutter run -d windows
```

- Click the X button to test close-to-tray functionality
- Look for the tray icon in the system tray
- Check console output for notification status

**Note**: In development/debug builds, Windows notifications may not appear due to lack of package identity.

#### **Production Testing**:

For reliable Windows notifications, the app must be packaged as an MSIX installer:

1. **Install MSIX package**:

   ```bash
   flutter pub add msix
   ```

2. **Configure pubspec.yaml**:

   ```yaml
   msix:
     display_name: PoliGen-AI
     publisher_display_name: Your Publisher Name
     identity_name: com.yourcompany.poligen_ai
     msix_version: 1.0.0.0
   ```

3. **Build MSIX package**:

   ```bash
   flutter pub run msix:create
   ```

4. **Install and test the MSIX package** for full notification functionality

#### **Why Windows Notifications May Not Work**:

- **Package Identity Required**: Windows toast notifications require apps to have package identity
- **Debug Builds**: Development builds lack the necessary Windows app registration
- **System Permissions**: Windows may block notifications from unregistered apps

#### **Workaround for Development**:

The app includes robust fallback behavior:

- Close-to-tray functionality works regardless of notification status
- Console logging provides feedback during development
- The core functionality (hiding to tray) is fully operational

### Notification Fallback

The app includes a robust fallback system:

- If native notifications fail, console logging provides feedback
- The close-to-tray functionality works regardless of notification status
- All platforms (Windows, macOS, Linux) are supported with appropriate notification methods

## Architecture

- **Clean Architecture**: Follows SOLID principles with clear separation of concerns
- **Services**: NotificationService handles cross-platform system notifications
- **Widgets**: Reusable UI components with Aurora effects and custom title bar
- **State Management**: Prepared for Riverpod integration (future enhancement)

## Dependencies

- `flutter_local_notifications`: Cross-platform system notifications
- `window_manager`: Desktop window management and controls
- `tray_manager`: System tray integration
- `google_fonts`: Typography with Inter font family

## Development Notes

- The maximize button is disabled to maintain consistent window sizing
- Window resizing is disabled for a controlled user experience
- The app uses a custom title bar on non-macOS platforms
- Asset `assets/Vector.ico` is used for the tray icon

## Contributing

1. Follow the established coding patterns and architecture
2. Test on all target platforms when making changes
3. Update documentation for new features
4. Ensure notifications work properly on Windows before submitting PRs

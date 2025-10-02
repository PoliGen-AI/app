# Settings Page Documentation

## Overview

The Settings Page provides a comprehensive configuration interface for the PoliGen AI application, allowing users to customize their experience across multiple categories.

## Features

### 🎨 Appearance

- **Dark Theme Toggle**: Switch between light and dark themes
- Real-time theme switching with immediate UI updates

### 🍪 Cookies and Privacy

- **Essential Cookies**: Required for basic app functionality (always enabled)
- **Functional Cookies**: Remember user preferences and settings
- **Performance Cookies**: Collect anonymous data to improve app performance
- **Marketing Cookies**: Used for personalized advertisements and content
- Smart dependency management - other cookie types are disabled when essential cookies are off

### 🔔 Notifications

- **Push Notifications**: Receive notifications about image generation progress
- **Sound Settings**: Toggle notification sounds on/off

### 🔒 Privacy and Data

- **Usage Analytics**: Share anonymous data to improve the app
- **Personalized Marketing**: Receive customized offers and content

### ⚙️ General Settings

- **Language Selection**: Choose interface language (Português, English, Español)
- **Auto-save**: Automatically save generated images to gallery
- **Tips and Tutorials**: Show helpful tips for new features

### 🖼️ Image Quality

- **Default Quality**: Set default image generation quality (Baixa, Média, Alta, Máxima)

## Technical Implementation

### State Management

- Uses `SettingsService` singleton for centralized state management
- Implements `ChangeNotifier` for reactive UI updates
- Persists settings using `SharedPreferences`

### Architecture

- Clean separation of concerns with dedicated service layer
- Reactive UI updates through `AnimatedBuilder`
- Consistent styling following app design patterns

### Data Persistence

- All settings are automatically saved to device storage
- Settings persist across app restarts
- Graceful fallback to default values if storage fails

## User Experience

### Navigation

- Accessible from dashboard via "Configurações" button in navbar
- Clean back navigation with consistent header design

### Visual Design

- Consistent with app's aurora background theme
- Organized into logical sections with clear icons
- Responsive layout that works on different screen sizes
- Intuitive switch and dropdown controls

### Feedback

- Real-time visual feedback for all setting changes
- Success notifications when settings are saved
- Confirmation dialog for destructive actions (reset to defaults)

## Settings Categories

1. **Theme Settings**: Visual appearance preferences
2. **Cookie Management**: Privacy and data collection controls
3. **Notification Preferences**: Communication and alert settings
4. **Privacy Controls**: Data sharing and marketing preferences
5. **General Options**: Language, auto-save, and tutorial settings
6. **Image Quality**: Default generation quality settings

## Future Enhancements

Potential areas for expansion:

- Advanced image generation parameters
- Export/import settings functionality
- Account-specific settings sync
- Accessibility options
- Performance monitoring settings
- Custom keyboard shortcuts

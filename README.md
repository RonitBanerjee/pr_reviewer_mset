# PR Wizard - Flutter GitHub PR Reviewer App

This project is a simple 2 screen app which allows users to view PRs for this repository.

## 📱 Features

- **🔐 Secure Authentication**: Simulated token-based authentication with persistent login
- **📋 PR Management**: View GitHub Pull Requests
- **🎨 Modern UI**: Clean, responsive design with dark/light theme support
- **⚡ Real-time Updates**: Pull-to-refresh functionality for latest PR data
- **📱 Cross-platform**: Works on mobile platforms and web.
- **🔄 State Management**: Built with BLoC pattern for robust state management

## 📁 Project Structure

```
pr_reviewer/
├── lib/
│   ├── constants/
│   │   ├── media_assets.dart
│   │   └── theme_colors.dart
│   ├── env/
│   │   └── environment_constants.dart
│   ├── helpers/
│   │   ├── services/
│   │   │   └── github_service.dart
│   │   └── utils/
│   │       └── shared_prefs.dart
│   ├── models/
│   │   └── pull_request.dart
│   ├── routing/
│   │   ├── app_router_config.dart
│   │   └── app_router_constants.dart
│   ├── screens/
│   │   ├── auth/
│   │   │   └── login.dart
│   │   ├── error_page.dart
│   │   └── home/
│   │       ├── bloc/
│   │       │   ├── home_bloc.dart
│   │       │   ├── home_event.dart
│   │       │   └── home_state.dart
│   │       └── home.dart
│   ├── widgets/
│   │   └── cards/
│   │       └── pr_card.dart
│   └── main.dart
├── assets/
│   └── git-login-image.png
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
├── pubspec.yaml
└── README.md
```

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/RonitBanerjee/pr_reviewer_mset.git
   cd pr_reviewer
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure GitHub Token Securely using `.env` File**
    - Go to GitHub Settings → Developer settings → Personal access tokens
    - Generate a new token with `repo` permissions
    - Create a `.env` file in the root of the project:
    ```
    GITHUB_TOKEN=your_github_token_here
    ```
    - Ensure this file is **excluded from version control** by checking that `.gitignore` includes:
    ```
    .env
    ```
    - The app uses `flutter_dotenv` to load environment variables at runtime. Your `main.dart` should include:
    ```dart
    await dotenv.load(fileName: ".env");
    final token = dotenv.env['GITHUB_TOKEN'];
    ```

4. **Update Repository Details**
   - Modify the owner and repo in `lib/screens/home/bloc/home_bloc.dart`:
   ```dart
   GitHubService(
     token: EnvironmentConstants.token,
     owner: 'your_github_username',
     repo: 'your_repository_name',
   )
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

## 🔐 Token Handling

The application implements a simulated secure token-based authentication system:

### Token Storage
- **SharedPreferences**: Tokens are securely stored using Flutter's SharedPreferences
- **Persistent Login**: Tokens persist across app restarts
- **Automatic Logout**: Token validation and automatic logout on expiration
- **.env**: The github token is stored in a .env file which is not commited to the repo


### Token Flow
1. **Login**: User enters credentials → Token saved to SharedPreferences
2. **API Calls**: Token included in Authorization header for GitHub API requests
3. **Validation**: Token checked on app startup for authentication state
4. **Logout**: Token cleared from SharedPreferences on logout

### Security Features
- **Bearer Token**: Uses proper Bearer token format for API authentication
- **Secure Storage**: Tokens stored locally with SharedPreferences
- **Token Refresh**: Automatic token validation and refresh mechanism

## 🌟 Bonus Features Implemented

### 1. **Pull to Refresh**
- Swipe down to refresh pull request data
- Real-time updates from GitHub API
- Smooth refresh animation with loading indicators

### 2. **Retry on Failure**
- Automatic retry mechanism for failed API calls
- User-friendly error handling with retry options
- Graceful degradation when network issues occur

### 3. **Responsive Layout**
- Adaptive design for different screen sizes
- Optimized layouts for mobile, tablet, and desktop
- Flexible UI components that scale appropriately

### 4. **Dark Mode**
- Complete dark/light theme support
- Automatic theme switching based on system preferences
- Consistent theming across all app components

### 5. **Animations or Shimmer Loading**
- Shimmer loading effects for content loading states
- Smooth transitions and micro-interactions
- Professional loading animations for better UX

## 🐞 Known Issues & Limitations

### Current Limitations
1. **Limited PR Actions**: Read-only functionality, no merge/close actions
2. **No Offline Support**: Requires internet connection for data
3. **Single Repository**: Can only view PRs from one repository at a time

### Technical Debt
- Error handling could be more comprehensive
- Unit tests not implemented
- CI/CD pipeline not set up

### Future Improvements
- [ ] Multi-repository support
- [ ] PR merge/close functionality
- [ ] Offline caching
- [ ] Push notifications
- [ ] Advanced filtering and search
- [ ] Unit and integration tests
- [ ] CI/CD pipeline setup

## 📹 Demo Video

### App Demo on Android
[![PR Wizard Demo](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://www.youtube.com/watch?v=YOUR_VIDEO_ID)

*Click the image above to watch the demo video*

### Demo Features Showcased
- Login flow and authentication
- Pull Request listing and details
- Dark/light theme switching
- Pull-to-refresh functionality
- Responsive design on different screen sizes
- Cross-platform compatibility

## 🛠️ Dependencies

### Core Dependencies
- `flutter_bloc: ^9.0.0` - State management
- `bloc: ^9.0.0` - BLoC pattern implementation
- `google_fonts: ^6.2.1` - Typography
- `go_router: ^5.2.0` - Navigation
- `shared_preferences: ^2.5.3` - Local storage
- `http: ^1.4.0` - HTTP requests
- `shimmer: ^3.0.0` - Loading animations

### Development Dependencies
- `flutter_test` - Testing framework
- `flutter_lints: ^5.0.0` - Code quality

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 👨‍💻 Author

**Ronit Banerjee**
- GitHub: [@ronitbanerjee](https://github.com/ronitbanerjee)
- Email: ronitban070@gmail.com

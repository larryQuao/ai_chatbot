# AI Chatbot Application with Flutter

This Flutter application provides a chatbot interface with customizable themes and smooth navigation.

## Features

- **Chat Interface**: A user-friendly chat interface that allows users to interact with the chatbot.
- **Customizable Themes**: The application uses Google Fonts for a modern and clean look.
- **Smooth Navigation**: Utilizes the `GetX` package for state management and navigation.
- **Backend Integration**: Communicates with a backend server to fetch chatbot responses.
- **Splash Screen**: Displays a splash screen while the app initializes.
- **Message Bubbles**: Differentiates between user and bot messages with distinct message bubbles.

## Getting Started

### Prerequisites

- **Flutter SDK**: Ensure you have Flutter installed on your machine. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- **Dart SDK**: Dart is included with Flutter, so no separate installation is needed.
- **Backend Server**: The application expects a backend server running at `http://127.0.0.1:8000/chat`. Ensure your backend server is up and running.

### Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/ai_chatbot_app.git
    cd ai_chatbot_app
    ```

2. **Install dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the application**:
    ```sh
    flutter run
    ```

### Project Structure

- `lib/main.dart`: Entry point of the application.
- `lib/screens/`: Contains the UI screens such as `chat_screen.dart` and `splash_screen.dart`.
- `lib/components/`: Contains reusable UI components like `chat_message_bubble.dart` and `message_input_area.dart`.
- `lib/controllers/`: Contains the controllers for managing state and business logic, such as `chat_controller.dart` and `chat_screen_controller.dart`.
- `assets/`: Contains the static assets like images and fonts.

### Dependencies

- **Flutter**: The core framework.
- **GetX**: For state management and navigation.
- **Google Fonts**: For custom fonts.
- **HTTP**: For making HTTP requests to the backend server.
- **UUID**: For generating unique conversation IDs.

### Contributing
Contributions are welcome! Please fork the repository and submit a pull request for any improvements or bug fixes.  

### License
This project is licensed under the MIT License
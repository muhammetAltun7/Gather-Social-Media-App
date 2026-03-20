# Gather

Gather is a social media mobile application developed using Flutter. Users can create an account, log in, share posts, like and comment on content, and manage their personal profiles.

The application was developed using Firebase Authentication, Cloud Firestore, Firebase Storage, and Flutter's built-in state management.

---

## Features

🔐 **User Authentication**
- Sign up with Firebase Authentication
- User login
- Secure logout

📸 **Post Sharing**
- Create and share posts
- Image upload via Firebase Storage
- Real-time post feed

❤️ **Likes & Comments**
- Like posts
- Comment on posts
- Delete posts
- Real-time interaction updates via Firestore

👤 **Profile Page**
- View and edit personal profile
- Username change
- Biography / bio section
- User post history

🎨 **Flutter UI**
- Custom widget usage
- Loading animations with Alert Dialog
- Responsive design for all screen sizes

---

## 🛠 Technologies Used

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Storage

---

## 📂 Project Structure

```bash
lib/
├── assets/                  # App assets
│   ├── appLogo.png
│   ├── logo.png
│   └── sendMessage.svg
├── auth/                    # Authentication
│   ├── auth_gate.dart
│   └── login_or_register.dart
├── components/              # Reusable widgets
│   ├── comment.dart
│   ├── comment_button.dart
│   ├── delete_button.dart
│   ├── gather_post.dart
│   ├── like_button.dart
│   ├── my_button.dart
│   ├── my_drawer.dart
│   ├── my_list_tile.dart
│   ├── my_post_text_field.dart
│   ├── my_text_box.dart
│   └── my_text_field.dart
├── helper/                  # Utility classes
│   └── helper_methods.dart
├── pages/                   # Application screens
├── firebase_options.dart
│ ── main.dart

```

---

## 🔥 Firebase Services

Firebase services were used throughout this project:

- **Firebase Authentication** → User authentication system
- **Cloud Firestore** → Real-time post and comment database
- **Firebase Storage** → Image and media file storage

---

## 🚀 Setup Instructions

**📦 Extract the Project**
- Download the repository and extract the ZIP file to a permanent folder on your computer.

**🛠 Open in Android Studio**
- Open Android Studio and select the **gather** folder as the project root.

**⚙️ Configure SDK**
- If you see a *"Dart SDK is not configured"* warning at the top, click on **"Open Dart settings"**
- Ensure the **"Enable Dart support for the project 'gather'"** checkbox is ticked
- Select your local Flutter SDK path *(e.g., `C:\src\flutter`)*

**📥 Fetch Dependencies**
- Open the terminal in Android Studio and run:

```bash
flutter pub get
```

**▶️ Run the App**
- Select your emulator or physical device
- Press the **Run (▶️)** button in Android Studio

---

## Developer

**MUHAMMET ALTUN**
Computer Engineering Student 🚀

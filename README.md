# Gather

Gather is a social media mobile application developed using Flutter. Users can create an account, log in, share posts, like and comment on content, and manage their personal profiles.

The application was developed using Firebase Authentication, Cloud Firestore, Firebase Storage, and Flutter's built-in state management.

<img width="294" height="633" alt="3" src="https://github.com/user-attachments/assets/75cacd7d-cf7f-477e-8baf-8b58be2baffb" />
<img width="301" height="629" alt="2" src="https://github.com/user-attachments/assets/15be5f2f-738c-4877-b5dd-2254e6b2f555" />
<img width="317" height="660" alt="1" src="https://github.com/user-attachments/assets/4a86389e-0e64-4a6f-87db-37d9b21e4f57" />
<img width="300" height="628" alt="9" src="https://github.com/user-attachments/assets/1f8538ef-f8bb-4a7c-89c8-7c6c6c40bd4d" />
<img width="299" height="632" alt="8" src="https://github.com/user-attachments/assets/cced56f0-a9a1-4125-999f-bedc38cc5c28" />
<img width="303" height="631" alt="7" src="https://github.com/user-attachments/assets/b453ba04-13f7-49c1-86ab-1725f036a239" />
<img width="298" height="632" alt="6" src="https://github.com/user-attachments/assets/926eeaa0-decf-40c6-a0fb-ca2a5e949dc0" />
<img width="300" height="628" alt="5" src="https://github.com/user-attachments/assets/099f055a-b3aa-4cc7-b051-2dfdf9e9fb3b" />
<img width="303" height="632" alt="4" src="https://github.com/user-attachments/assets/76f060c1-c6eb-45e1-9a61-6c6ebb4bb562" />

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

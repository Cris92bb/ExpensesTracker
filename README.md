# Expenses Tracker

A Flutter-based mobile application designed to help users track their daily expenses efficiently. The app provides a user-friendly interface to add, view, and manage expenses, along with features like customizable preferences and light/dark theme support.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)

### Building and Running the App

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/expenses-tracker.git
   ```
   (Replace `your-username/expenses-tracker.git` with the actual repository URL)
2. **Navigate to the project directory:**
   ```bash
   cd expenses-tracker
   ```
3. **Install dependencies:**
   ```bash
   flutter pub get
   ```
4. **Run the app:**
   ```bash
   flutter run
   ```

## Features

- **Add New Expenses:** Easily add new expenses with details like amount, description, and date.
- **List Expenses:** View a comprehensive list of all recorded expenses.
- **Total Expenses Display:** Keep track of the total amount spent.
- **Horizontal Slider:** (Describe the purpose of the slider, e.g., "For navigating expenses by month/budget period.")
- **Light and Dark Themes:** Choose between light and dark visual themes for comfortable viewing.
- **Customizable Preferences:**
    - Set preferred currency.
    - Define payday to align with your financial cycle.
    - Set a maximum spending amount as a budget guideline.
- **Local Data Storage:** Expenses are stored locally on the device using sqflite, ensuring data privacy and offline access.

## Project Structure

The project is organized as follows:

- **`lib/main.dart`**: The main entry point of the application and home screen.
- **`lib/Views/`**: Contains the UI screens of the application.
    - **`CreateExpense.dart`**: UI for adding new expenses.
    - **`ExpenseDetails.dart`**: UI for viewing the details of a specific expense.
    - **`Preferences.dart`**: UI for managing user preferences.
- **`lib/DataModels/`**: Contains the data models used within the app.
    - **`SingleExpense.dart`**: Defines the structure for an individual expense record.
- **`lib/Helpers/`**: Contains helper classes for various functionalities.
    - **`DatabaseHelper.dart`**: Manages all database interactions (CRUD operations) using sqflite.
- **`lib/CustomWidgets/`**: Contains custom UI widgets used across different screens.
- **`pubspec.yaml`**: Defines project dependencies, custom fonts, and other metadata.

## Dependencies

The project utilizes the following major dependencies:

- `sqflite`: For local database storage.
- `shared_preferences`: For storing user preferences.
- `datetime_picker_formfield`: For easy date and time selection in forms.
- `intl`: For internationalization and date/number formatting.

## Contributing

Contributions are welcome! If you have suggestions or improvements, please feel free to fork the repository and submit a pull request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

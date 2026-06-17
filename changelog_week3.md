# Week 3 Changelog

## API-Connected Functional App
- **Dynamic Data Fetching**: We created a `programs.json` file inside the `assets/` directory to act as a mock API.
- **Program List Screen Updated**: `ProgramListScreen` now dynamically fetches the list of programs asynchronously using `rootBundle.loadString()`. It parses the JSON and updates the UI state.
- **Loading & Error Handling**: While data is being parsed or waiting for the mocked network delay, a `CircularProgressIndicator` is shown. If fetching fails, a clear error message is displayed.
- **Registration Form Implementation**: Added a new screen called `RegistrationScreen`. This screen is accessed by tapping the "Enroll Now" button on the `ProgramDetailScreen`.
- **Form Validation**: The registration form takes Name, Email, Password, and Experience Level (dropdown). The form utilizes Flutter's `FormState` to validate input:
  - Name is required.
  - Email is required and must follow standard email Regex validation.
  - Password is required and must be at least 6 characters.
  - Experience Level dropdown selection is required.
- **Form Feedback**: Upon successful validation and submission, an `AlertDialog` pops up thanking the user and confirming their registration, demonstrating clear feedback to users during data submission.

## File Changes Overview
- **`pubspec.yaml`**: Registered `assets/programs.json`.
- **`lib/screens/program_list_screen.dart`**: Implemented `_fetchPrograms` and `FutureBuilder`/state logic.
- **`lib/screens/program_detail_screen.dart`**: Updated "Enroll Now" action to route to `RegistrationScreen`.
- **`lib/screens/registration_screen.dart`**: Created new file holding the Stateful form widget and validation logic.
- **`assets/programs.json`**: New sample data source file.

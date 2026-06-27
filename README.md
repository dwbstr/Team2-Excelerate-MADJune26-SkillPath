# SkillPath — Mobile Learning App



<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.0%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-3.0%2B-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Status-Week%204%20Complete-4A90D9?style=for-the-badge"/>
</p>

---

## Vision

To make learning simple, accessible, and engaging by connecting users with educational programs, resources, and real-time updates — all in one platform.

---

## Objectives

| # | Objective |
|---|-----------|
| 1 | Cross-platform development (Android, iOS & Web) using Flutter |
| 2 | User authentication (Email Sign-Up + Google Sign-In placeholder) |
| 3 | Program discovery with category filters and level-based filtering |
| 4 | Progress tracking and enrollment management |
| 5 | Persistent data integration using SharedPreferences |

---

## Navigation Flow

```
Login → Sign Up → Home → Program Listing → Program Detail → Enroll → Dashboard
```

---

## Team

| Name | Role |
|------|------|
| Praise Esheya | Team Lead |
| Damian Amegashie | Project Manager |
| Ruth Nwosu | Project Scribe |
| Asma Shahzadi | Project Lead |
| Nanubala Sravani | UI/UX Designer |
| Anindya Roy | Team Member |
| Soumya Das | Team Member |
| Pratyush Srivastava | Team Member |

---

## Setup

```bash
# 1. Install Flutter SDK (>=3.0.0)
# 2. Clone this repo
git clone https://github.com/dwbstr/slu-0106-mad-team-2.git
cd slu-0106-mad-team-2

# 3. Get dependencies
flutter pub get

# 4. Run the app (Android, iOS, Web, or Windows)
flutter run
```

> **Windows users:** Flutter plugins (like `shared_preferences`) require Developer Mode.  
> Open PowerShell and run `start ms-settings:developers` to enable it before running.

---

## Project Structure

```
lib/
├── main.dart                        # App entry point, theme & UserSession init
├── app_theme.dart                   # Centralized design system (NEW Week 4)
├── models/
│   └── program.dart                 # Program, Instructor, Review models
├── services/
│   ├── program_service.dart         # Async JSON loader (programs.json)
│   └── user_session.dart            # SharedPrefs singleton (NEW Week 4)
└── screens/
    ├── login_screen.dart            # Login with gradient header & validation
    ├── signup_screen.dart           # Account creation screen (NEW Week 4)
    ├── home_screen.dart             # Home with categories & featured programs
    ├── program_list_screen.dart     # Filterable & searchable program listing
    ├── program_detail_screen.dart   # Program detail with tabs, enroll & feedback
    ├── registration_screen.dart     # Enrollment form with data persistence
    └── dashboard_screen.dart        # Learner profile & enrolled programs (NEW Week 4)
```

---

## Week 1 — Planning & Wireframes ✅

### App Proposal

**SkillPath** is a cross-platform mobile learning and program discovery app built with Flutter. It helps users explore educational programs, access learning resources, provide feedback, and stay updated through announcements and notifications.

### User Journeys

**Learner Journey**
1. Downloads app → creates account via email or Google
2. Browses programs → filters by category
3. Enrolls → accesses videos, PDFs, quizzes, and assignments
4. Tracks progress → completes lessons → receives certificate

**Admin Journey**
1. Logs into admin dashboard
2. Creates and manages programs (uploads content, resources)
3. Monitors learner activity and analytics
4. Sends announcements and push notifications
5. Reviews learner feedback to improve programs

### Wireframes Designed

| Screen | Status |
|--------|--------|
| Login Screen | ✅ |
| Home Screen | ✅ |
| Program Listing Screen | ✅ |
| Program Detail Screen | ✅ |

### Week 1 Deliverables

- ✅ App proposal documented
- ✅ Wireframes designed (Login, Home, Program Listing, Program Detail)
- ✅ GitHub repo initialized

---

## Week 2 — UI Screens Implementation ✅

### What Was Built

All four core screens were translated from wireframes into functional Flutter UI with navigation implemented between them.

---

### Screen 1 — Login Screen

**File:** `lib/screens/login_screen.dart`

**Features:**
- SkillPath logo and tagline
- Email and password text fields with input validation styling
- Password visibility toggle
- Forgot Password link
- Login button → navigates to Home Screen
- Google Sign-In button
- Sign Up link

<p align="center">
  <img src="assets/screenshots/login.png" width="280" alt="Login Screen"/>
</p>

---

### Screen 2 — Home Screen

**File:** `lib/screens/home_screen.dart`

**Features:**
- Personalized greeting ("HI, Learner 👋")
- Search bar with filter icon
- Category icons: Tech, Design, Business, Marketing
- Horizontal scrollable featured program cards
- "See all" shortcut → navigates to Program Listing
- 5-tab bottom navigation bar (Home, Notifications, Friends, Learn, Profile)

<p align="center">
  <img src="assets/screenshots/home.png" width="280" alt="Home Screen"/>
</p>

---

### Screen 3 — Program Listing Screen

**File:** `lib/screens/program_list_screen.dart`

**Features:**
- Search bar for program discovery
- Filter chips: Popular, All, Beginner, Advanced, Latest
- Scrollable program list with thumbnail, title, description, and duration
- Tap any program → navigates to Program Detail Screen
- Play arrow icon on each tile

<p align="center">
  <img src="assets/screenshots/Programms.png" width="280" alt="Program Listing Screen"/>
</p>

---

### Screen 4 — Program Detail Screen

**File:** `lib/screens/program_detail_screen.dart`

**Features:**
- Hero image with level badge (e.g., "Beginner friendly")
- Program title and star rating with review count
- Bookmark toggle in app bar
- Three tabs: **Overview**, **Instructor**, **Review**
  - Overview: description, duration, certification info
  - Instructor: profile card with bio
  - Review: learner reviews with star ratings
- Sticky "Enroll Now" button at bottom with snackbar confirmation

<p align="center">
  <img src="assets/screenshots/Program Details.png" width="280" alt="Program Detail Screen"/>
</p>

---

### Navigation Map

```
LoginScreen
    └──(Login button)──► HomeScreen
                              └──(See all / Program card)──► ProgramListScreen
                                                                  └──(Program tile)──► ProgramDetailScreen
                                                                                            └──(Enroll Now)──► Snackbar ✅
```

### Design Choices

| Decision | Reason |
|----------|--------|
| Color: `#4A90D9` (blue) | Matches Excelerate/SkillPath learning brand |
| Color: `#4A4A6A` (dark) | Used for primary CTAs (Login, Enroll Now) for contrast |
| Bottom nav bar | Matches wireframe; enables quick access to all sections |
| Filter chips with checkmark | Clear visual feedback on active filter |
| `SingleChildScrollView` on Login | Prevents overflow on smaller screens |
| `TabBarView` fixed height | Prevents unbounded height error inside `SingleChildScrollView` |

### Week 2 Deliverables

- ✅ Login Screen implemented in Flutter
- ✅ Home Screen with categories, search, and program cards
- ✅ Program Listing Screen with filter chips and search
- ✅ Program Detail Screen with tabs and Enroll button
- ✅ Navigation implemented: Login → Home → Programs → Detail
- ✅ Branding applied consistently across all screens
- ✅ GitHub repository updated with latest code

---

## Week 3 — Data Fetching, Forms & Refactoring ✅

### What Was Built
We integrated sample JSON data to dynamically populate our program list, simulating real API calls. We refactored the app architecture to use a clean `models` and `services` structure, and introduced interactive forms with robust input validation.

### Deliverables
- ✅ **API Integration:** Created `assets/programs.json` and a `ProgramService` to fetch dynamic program data asynchronously using `rootBundle`.
- ✅ **Registration Form:** Built `RegistrationScreen` with proper form validation (valid email format, minimum password length, etc.) using `TextFormField` and `DropdownButtonFormField`.
- ✅ **Feedback Form:** Added a functional feedback/rating form on the `ProgramDetailScreen`.
- ✅ **Search Option:** Implemented search functionality to allow learners to easily find specific programs.
- ✅ **App Architecture:** Refactored the app structure into `models/` and `services/` for better code maintainability.

### Screens Added

#### Screen 5 — Registration Screen
Contains form validation to ensure users enter valid details before enrolling in a program.
<p align="center">
  <img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/bf201de7-f8df-401d-a897-98f709f981bf" />
</p>

#### Screen 6 — Feedback Form (Program Detail)
Allows learners to leave reviews and feedback on specific courses.
<p align="center">
  <img width="720" height="1600" alt="image" src="https://github.com/user-attachments/assets/02c02c33-dc58-4eb6-b2d2-64c2e9124a6a" />
</p>

### State Management & User Experience
- ✅ Used Flutter's `setState()` for managing loading, success, and error states.
- ✅ Displayed `CircularProgressIndicator` while fetching program data to show loading states.
- ✅ Implemented `try-catch` error handling for JSON loading failures, displaying user-friendly error messages instead of crashing.

### Files Added & Modified
- `assets/programs.json` (New data source)
- `lib/models/program.dart` (New data model)
- `lib/services/program_service.dart` (New API service)
- `lib/screens/registration_screen.dart` (New screen)
- Modified `program_list_screen.dart` to connect JSON data
- Modified `program_detail_screen.dart` to add the feedback form

---

## Week 4 — Final Complete App ✅

### What Was Built
We completed the final, polished version of SkillPath. This week focused on three pillars: **consistent branding** across all screens using a centralized design system, **smooth navigation** with a fully functional bottom nav and proper screen transitions, and **working data integration** using `shared_preferences` to persist user data and enrollments across app restarts.

### Key Improvements & Bug Fixes

| Issue (Before) | Fix (Week 4) |
|---|---|
| "Sign Up" link on Login did nothing | Now navigates to a full `SignUpScreen` |
| Bottom nav tabs 2–4 did nothing | 3-tab nav: Home, Programs, Profile — all functional |
| Filter chips didn't actually filter | Now truly filter `programs.json` data by `program.level` |
| Enrolled programs lost on app restart | `shared_preferences` persists enrollment list |
| User name/email lost on app restart | `shared_preferences` persists user profile |
| No "already enrolled" state | Program Detail shows ✅ badge if previously enrolled |
| Inconsistent colors/spacing across screens | Centralized `AppTheme` used by every screen |
| Hero image was a flat blue rectangle | Gradient with category-specific colors + decorative circles |
| No profile/dashboard screen | New `DashboardScreen` with stats + enrolled programs |

---

### New Infrastructure

#### `lib/app_theme.dart` — Design System
A centralized design system shared across all screens:
- **Color tokens**: `primary`, `dark`, `background`, `surface`, level colors (Beginner=green, Intermediate=orange, Advanced=red), category colors
- **Gradients**: `primaryGradient`, `darkGradient`, `categoryGradient(category)`
- **Typography**: `h1`, `h2`, `h3`, `body`, `bodySmall`, `label` presets
- **Input decoration**: `AppTheme.inputDecoration()` helper used by all form fields
- **Button styles**: `AppTheme.primaryButton()`, `AppTheme.darkButton()`
- **Page transitions**: `AppTheme.slideRoute()` — smooth 280ms slide animation
- **ThemeData**: Single source of truth for `MaterialApp` theme

#### `lib/services/user_session.dart` — Data Persistence
A singleton backed by `shared_preferences` that persists across app restarts:

| SharedPrefs Key | Type | Purpose |
|---|---|---|
| `user_name` | String | Saved on Sign Up / Registration |
| `user_email` | String | Saved on Sign Up / Registration |
| `enrolled_programs` | `List<String>` | Enrolled program titles |

**How it works:**
1. `UserSession.instance.init()` is called in `main()` before `runApp()`
2. It loads `programs.json` and reads SharedPrefs simultaneously
3. Enrolled program titles are cross-referenced with live JSON data to rebuild `Program` objects
4. `enroll(program)` adds to list and writes to SharedPrefs immediately
5. `logout()` clears all keys and resets in-memory state

---

### New Screens (Week 4)

#### Screen 7 — Sign Up Screen
**File:** `lib/screens/signup_screen.dart`

Full account creation screen accessible from the Login screen's "Sign Up" link:
- Full Name, Email, Password, Confirm Password fields
- Complete validation (email format, password match, min length)
- Saves user profile to `shared_preferences` on submit
- Navigates to `HomeScreen` clearing the back stack

#### Screen 8 — Learner Dashboard
**File:** `lib/screens/dashboard_screen.dart`

Profile and progress hub accessible via the "Profile" tab on the bottom nav:
- User avatar with initials circle
- Name and email (read from `UserSession` / `shared_preferences`)
- Stats row: Enrolled count, Completed, In Progress
- List of enrolled programs with category gradient icons, level badges, and progress bars
- "Browse Programs" CTA when no programs enrolled
- Logout button — clears all `SharedPreferences` data and navigates to `LoginScreen`

---

### Screens Updated (Week 4)

#### Login Screen (Revamped)
- Gradient header (blue → purple) with logo icon
- Loading spinner inside Login button during authentication simulation
- Working **Forgot Password** dialog with email input
- **Sign Up** link now navigates to `SignUpScreen`

#### Home Screen (Revamped)
- Gradient welcome banner showing user's first name (from `UserSession`)
- **3-tab bottom navigation**: Home → Programs → Profile (all functional)
- Category icons use per-category colors (Tech=blue, Design=purple, Business=green, Marketing=orange)
- Featured program cards with gradient thumbnails, level badges, and star ratings
- Stats banner showing program count, categories, and learner count

#### Program Listing Screen (Revamped)
- **Filter chips now actually filter**: Beginner/Intermediate/Advanced filter `program.level` from JSON
- Popular → sorts by rating descending
- Search clears button (✕) when text is entered
- Search covers title, description, and category fields
- **Empty state** widget with "Clear Filters" CTA
- **Error state** with Retry button
- Program cards show gradient thumbnail, level badge (color-coded), star rating, duration

#### Program Detail Screen (Revamped)
- **Gradient hero area** using category-specific colors with decorative background circles
- Category icon centered in hero
- **"Already Enrolled ✓"** green badge in hero when user has previously enrolled
- "Enroll Now" button replaced with disabled "Already Enrolled" outlined button if enrolled
- Instructor tab shows initials avatar instead of generic icon
- Review tiles show reviewer's initials circle
- Feedback form: star rating tap-selector + text area + submit button

#### Registration Screen (Revamped)
- **Program info banner** at top with gradient background, program title, duration, level
- Pre-fills Name and Email from `UserSession` if user already signed up
- On submit: calls `UserSession.saveUser()` + `UserSession.enroll(program)` (writes to SharedPrefs)
- **Success dialog** with check icon animation
- Navigates to `HomeScreen` clearing the full navigation stack

---

### Data Integration (Week 4)

```
App Launch → UserSession.init()
    ├── Loads assets/programs.json asynchronously
    ├── Reads SharedPreferences (name, email, enrolled_programs)
    └── Cross-references stored titles with JSON → rebuilds Program objects

User Enrolls → UserSession.enroll(program)
    └── Appends title to List<String> → writes to SharedPreferences

Hot Restart / App Reopen
    └── UserSession.init() restores all data ✅
        └── Dashboard shows enrolled programs ✅
        └── Program Detail shows "Already Enrolled" badge ✅

Logout → UserSession.logout()
    └── Clears all SharedPreferences keys
    └── Resets in-memory state
    └── Navigates to LoginScreen (stack cleared) ✅
```

### Dependencies Added (Week 4)
- `shared_preferences: ^2.3.2` — local key-value persistence

### Files Added & Modified (Week 4)
- `pubspec.yaml` — added `shared_preferences` dependency
- `assets/programs.json` — added `category` field; added 2 new programs (8 total)
- `lib/models/program.dart` — added `category` field
- `lib/app_theme.dart` (**NEW**) — centralized design system
- `lib/services/user_session.dart` (**NEW**) — SharedPrefs-backed singleton
- `lib/main.dart` — async init of `UserSession` before `runApp()`
- `lib/screens/login_screen.dart` — full revamp
- `lib/screens/signup_screen.dart` (**NEW**) — account creation
- `lib/screens/home_screen.dart` — full revamp
- `lib/screens/program_list_screen.dart` — working filters + better UI
- `lib/screens/program_detail_screen.dart` — gradient hero + enrolled state
- `lib/screens/registration_screen.dart` — data persistence integration
- `lib/screens/dashboard_screen.dart` (**NEW**) — learner profile & enrolled programs

### Week 4 Deliverables

- ✅ All key screens implemented: Login, Sign Up, Home, Program Listing, Program Detail, Registration, Dashboard
- ✅ Smooth navigation with slide transitions across all screens
- ✅ Consistent branding via centralized `AppTheme` design system
- ✅ Working data integration: `programs.json` → `ProgramService` → UI
- ✅ Form submissions persist data via `shared_preferences`
- ✅ Enrolled programs survive app restarts (cross-referenced with live JSON)
- ✅ Filter chips genuinely filter programs by level
- ✅ "Already Enrolled" state shown on Program Detail
- ✅ `dart analyze` passes with 0 errors, 0 warnings
- ✅ App runs successfully on Chrome (web) and Android

---

## Roadmap

| Week | Focus | Status |
|------|-------|--------|
| Week 1 | Planning, wireframes, repo setup | ✅ Done |
| Week 2 | Core UI screens + navigation | ✅ Done |
| Week 3 | Backend integration, real data, auth | ✅ Done |
| Week 4 | Final complete app, data persistence, polish | ✅ Done |

---

# Team2-Excelerate SLU 0106 MAD - WEEK 4 FINAL

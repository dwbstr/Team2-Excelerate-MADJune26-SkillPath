# Week 4 Final — Walkthrough

## Result: `dart analyze` ✅ — 0 errors, 0 warnings

---

## Files Created / Modified

### New Files

| File | Purpose |
|------|---------|
| `lib/app_theme.dart` | Centralized design system (colors, gradients, styles, transitions) |
| `lib/services/user_session.dart` | SharedPrefs singleton — persists name, email, enrolled programs |
| `lib/screens/signup_screen.dart` | Account creation with full validation → saves to SharedPrefs |
| `lib/screens/dashboard_screen.dart` | Profile + enrolled programs + logout |

### Modified Files

| File | Key Changes |
|------|-------------|
| `pubspec.yaml` | Added `shared_preferences: ^2.3.2` |
| `assets/programs.json` | Added `category` field + 2 new programs (8 total) |
| `lib/models/program.dart` | Added `category` field |
| `lib/main.dart` | `await UserSession.instance.init()` before `runApp()` |
| `lib/screens/login_screen.dart` | Gradient header, loading button, Forgot Password dialog, Sign Up → SignUpScreen |
| `lib/screens/home_screen.dart` | Gradient banner with user name, 3-tab nav, stats banner |
| `lib/screens/program_list_screen.dart` | Filter chips now actually filter by level, empty state, error+retry |
| `lib/screens/program_detail_screen.dart` | Gradient hero, "Already Enrolled ✓" badge, avatar initials in reviews |
| `lib/screens/registration_screen.dart` | Program info banner, calls `UserSession.enroll()` → persists to SharedPrefs |

---

## Navigation Map (Final)

```
LoginScreen
    ├──(Login) ─────────────────► HomeScreen
    └──(Sign Up link) ──────────► SignUpScreen ──(Submit)──► HomeScreen

HomeScreen (3-tab bottom nav)
    ├── Tab 0: Home
    │       ├──(Category tap) ──► ProgramListScreen
    │       └──(See all / Card) ► ProgramListScreen
    ├── Tab 1: Programs ─────────► ProgramListScreen
    └── Tab 2: Profile ──────────► DashboardScreen

ProgramListScreen (filters: All / Popular / Beginner / Intermediate / Advanced)
    └──(Tap program) ───────────► ProgramDetailScreen
                                        ├── Already Enrolled → disabled button ✓
                                        └──(Enroll Now) ────► RegistrationScreen
                                                                    └──(Submit) ─► HomeScreen (clear stack)
DashboardScreen
    ├── Shows persisted enrolled programs from SharedPrefs
    ├──(Browse Programs) ───────► ProgramListScreen
    └──(Logout) ────────────────► SharedPrefs cleared → LoginScreen
```

---

## Data Integration Flow

```
App Launch
    └── UserSession.init()
            ├── Loads programs.json → _allPrograms
            ├── Reads SharedPrefs → name, email
            └── Cross-references stored titles with _allPrograms
                    → rebuilds List<Program> enrolledPrograms ✅

Sign Up / Register
    └── UserSession.saveUser(name, email) → SharedPrefs
    └── UserSession.enroll(program) → SharedPrefs

Hot Restart → Data still there ✅
Logout → SharedPrefs cleared → Dashboard shows empty ✅
```

---

## How to Run

> **Windows Note:** Developer Mode is required for `shared_preferences` plugin symlinks.  
> Run `start ms-settings:developers` in PowerShell, enable it, then:

```bash
flutter pub get
flutter run
```

---

## Verification Checklist

- [ ] Login with any email + 6+ char password → HomeScreen
- [ ] Sign Up → fill form → HomeScreen shows your first name in banner
- [ ] Browse Programs → filter by Beginner/Intermediate/Advanced → list updates
- [ ] Tap program → Enroll Now → fill registration → success dialog → Home
- [ ] Profile tab → Dashboard shows enrolled program with progress bar
- [ ] **Hot restart** → Dashboard still shows enrolled program ✅ (SharedPrefs)
- [ ] Feedback form → Review tab → submit → green snackbar
- [ ] Logout → LoginScreen → Dashboard is empty (cleared)
- [ ] Program Detail on previously enrolled program → shows "Already Enrolled ✓"

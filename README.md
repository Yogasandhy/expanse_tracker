# 💰 Expense Tracker

A simple and clean Flutter expense tracking app with Supabase backend. Track your income and expenses easily with a modern UI.

## ✨ Features

- 📊 **Dashboard**: View balance and recent transactions
- 💳 **Add Transactions**: Quick income/expense entry
- 📱 **All Transactions**: Browse all your financial records
- 🌙 **Dark/Light Mode**: Theme switching
- 🎯 **Categories**: Organize by Food, Transport, Entertainment, etc.

## 🛠️ Tech Stack

- **Flutter** - Mobile app framework
- **Supabase** - Backend database and API
- **BLoC** - State management
- **Clean Architecture** - Code organization

## 🚀 Setup

1. Clone the repository
```bash
git clone https://github.com/Yogasandhy/expanse_tracker.git
cd expanse_tracker
```

2. Install dependencies
```bash
flutter pub get
```

3. Setup Supabase database
   - Run the SQL scripts in `/docs/SETUP_DATABASE_NOW.sql`
   - Update Supabase config in `lib/core/constants/supabase_config.dart`

4. Run the app
```bash
flutter run
```

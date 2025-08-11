# 💰 Expense Tracker

A modern and beautiful Flutter expense tracking application built with Clean Architecture and BLoC pattern. Track your income and expenses with ease while enjoying a sleek, responsive design.

## ✨ Features

- **📊 Dashboard Overview**: Get a quick overview of your financial status with balance cards and recent transactions
- **💳 Transaction Management**: Add, view, and track all your income and expenses
- **🎯 Category Organization**: Organize transactions by categories (Food, Transportation, Entertainment, etc.)
- **🌙 Dark/Light Mode**: Toggle between dark and light themes for comfortable viewing
- **📱 Responsive Design**: Works seamlessly across different screen sizes
- **🎨 Modern UI**: Clean and intuitive Material 3 design with custom gradients and shadows
- **⚡ Real-time Updates**: Instant updates using BLoC state management

## 🏗️ Architecture

This project follows **Clean Architecture** principles with the following layers:

```
lib/
├── core/                 # Core utilities and constants
│   ├── constants/        # App constants, colors, strings
│   ├── theme/           # App theming
│   └── utils/           # Helper utilities
├── data/                # Data layer
│   ├── datasources/     # Data sources (local/remote)
│   ├── models/          # Data models
│   └── repositories_impl/ # Repository implementations
├── domain/              # Domain layer
│   ├── entities/        # Business entities
│   ├── repositories/    # Repository contracts
│   └── usecases/        # Business logic
└── presentation/        # Presentation layer
    ├── blocs/           # BLoC state management
    ├── pages/           # UI screens
    └── widgets/         # Reusable widgets
```

## 🛠️ Tech Stack

- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language
- **flutter_bloc**: State management using BLoC pattern
- **Google Fonts**: Beautiful typography with Inter font family
- **Material 3**: Modern design system
- **Clean Architecture**: Maintainable and testable code structure

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Yogasandhy/expanse_tracker.git
   cd expanse_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Screenshots

### Light Mode
- Modern dashboard with financial overview
- Clean transaction forms
- Intuitive category selection

### Dark Mode
- Consistent dark theme across all screens
- Eye-friendly colors for nighttime use
- Maintained visual hierarchy

## 🎯 Key Components

### Dashboard
- **Balance Cards**: Display total balance, income, and expenses
- **Recent Transactions**: Quick view of latest financial activities
- **Theme Toggle**: Switch between light and dark modes

### Transaction Management
- **Add Transaction**: Easy form to input new transactions
- **Category Selection**: Visual grid of expense/income categories
- **Date Selection**: Pick transaction dates with calendar
- **Amount Input**: Large, clear numeric input

### Categories
- Food & Dining 🍽️
- Transportation 🚗
- Entertainment 🎬
- Shopping 🛍️
- Health 🏥
- Salary 💼
- Freelance 💻
- Investment 📈

## 🔧 Configuration

### Theme Customization
Modify colors and styling in `lib/core/theme/app_theme.dart`

### Adding New Categories
Update the category list in `lib/presentation/pages/transactions/add_transaction_page.dart`

## 📝 Development Notes

### State Management
The app uses BLoC pattern for predictable state management:
- `TransactionBloc`: Manages transaction data and operations
- `ThemeBloc`: Handles theme switching functionality

### Color Consistency
All screens use consistent color schemes:
- **Dark Mode**: `Color(0xFF1A1A1A)` background, `Color(0xFF2D3748)` cards
- **Light Mode**: `Color(0xFFF8FAFC)` background, white cards
- **Accent Colors**: Green for income, red for expenses

### Responsive Design
- Uses `Flexible` widgets for responsive layouts
- `CustomScrollView` with `SliverList` for smooth scrolling
- Proper constraint handling to prevent overflow issues

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Yogasandhy**
- GitHub: [@Yogasandhy](https://github.com/Yogasandhy)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for the design guidelines
- Google Fonts for the beautiful typography
- Community contributors and testers

---

## 🚧 Roadmap

- [ ] Data persistence with SQLite
- [ ] Export transactions to CSV
- [ ] Budget tracking and alerts
- [ ] Charts and analytics
- [ ] Multi-currency support
- [ ] Backup and sync functionality

## 📞 Support

If you found this project helpful, please consider giving it a ⭐ on GitHub!

For questions or support, please open an issue in the GitHub repository.

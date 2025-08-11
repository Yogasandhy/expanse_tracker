import 'package:uuid/uuid.dart';
import '../models/category_model.dart';
import '../models/transaction_model.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/entities/budget.dart';

class LocalDummyDataSource {
  static const _uuid = Uuid();

  // Payment Methods
  static final List<PaymentMethod> _paymentMethods = [
    const PaymentMethod(
      id: 'pm1',
      name: 'Cash',
      iconName: 'moneyBill',
      colorHex: '#4CAF50',
    ),
    const PaymentMethod(
      id: 'pm2',
      name: 'E-Wallet',
      iconName: 'wallet',
      colorHex: '#2196F3',
    ),
    const PaymentMethod(
      id: 'pm3',
      name: 'Bank',
      iconName: 'buildingColumns',
      colorHex: '#FF9800',
    ),
    const PaymentMethod(
      id: 'pm4',
      name: 'Credit Card',
      iconName: 'creditCard',
      colorHex: '#9C27B0',
    ),
  ];

  // Categories
  static final List<CategoryModel> _categories = [
    // Expense Categories
    const CategoryModel(
      id: 'cat1',
      name: 'Food',
      iconName: 'utensils',
      colorHex: '#FF6B6B',
      isIncomeCategory: false,
      subcategories: [
        SubcategoryModel(
          id: 'sub1',
          name: 'Coffee',
          iconName: 'mugHot',
          categoryId: 'cat1',
        ),
        SubcategoryModel(
          id: 'sub2',
          name: 'Restaurant',
          iconName: 'utensils',
          categoryId: 'cat1',
        ),
        SubcategoryModel(
          id: 'sub3',
          name: 'Groceries',
          iconName: 'cartShopping',
          categoryId: 'cat1',
        ),
      ],
    ),
    const CategoryModel(
      id: 'cat2',
      name: 'Transport',
      iconName: 'car',
      colorHex: '#4ECDC4',
      isIncomeCategory: false,
      subcategories: [
        SubcategoryModel(
          id: 'sub4',
          name: 'Fuel',
          iconName: 'gasPump',
          categoryId: 'cat2',
        ),
        SubcategoryModel(
          id: 'sub5',
          name: 'Public Transport',
          iconName: 'bus',
          categoryId: 'cat2',
        ),
        SubcategoryModel(
          id: 'sub6',
          name: 'Taxi',
          iconName: 'taxi',
          categoryId: 'cat2',
        ),
      ],
    ),
    const CategoryModel(
      id: 'cat3',
      name: 'Entertainment',
      iconName: 'gamepad',
      colorHex: '#45B7D1',
      isIncomeCategory: false,
      subcategories: [
        SubcategoryModel(
          id: 'sub7',
          name: 'Movie',
          iconName: 'film',
          categoryId: 'cat3',
        ),
        SubcategoryModel(
          id: 'sub8',
          name: 'Music',
          iconName: 'music',
          categoryId: 'cat3',
        ),
      ],
    ),
    const CategoryModel(
      id: 'cat4',
      name: 'Shopping',
      iconName: 'shoppingBag',
      colorHex: '#96CEB4',
      isIncomeCategory: false,
      subcategories: [
        SubcategoryModel(
          id: 'sub9',
          name: 'Clothes',
          iconName: 'shirt',
          categoryId: 'cat4',
        ),
        SubcategoryModel(
          id: 'sub10',
          name: 'Electronics',
          iconName: 'laptop',
          categoryId: 'cat4',
        ),
      ],
    ),
    const CategoryModel(
      id: 'cat5',
      name: 'Bills',
      iconName: 'fileInvoiceDollar',
      colorHex: '#FECA57',
      isIncomeCategory: false,
      subcategories: [
        SubcategoryModel(
          id: 'sub11',
          name: 'Electricity',
          iconName: 'bolt',
          categoryId: 'cat5',
        ),
        SubcategoryModel(
          id: 'sub12',
          name: 'Internet',
          iconName: 'wifi',
          categoryId: 'cat5',
        ),
      ],
    ),
    // Income Categories
    const CategoryModel(
      id: 'cat6',
      name: 'Salary',
      iconName: 'moneyBillWave',
      colorHex: '#4CAF50',
      isIncomeCategory: true,
      subcategories: [
        SubcategoryModel(
          id: 'sub13',
          name: 'Basic Salary',
          iconName: 'moneyBillWave',
          categoryId: 'cat6',
        ),
        SubcategoryModel(
          id: 'sub14',
          name: 'Bonus',
          iconName: 'gift',
          categoryId: 'cat6',
        ),
      ],
    ),
    const CategoryModel(
      id: 'cat7',
      name: 'Investment',
      iconName: 'chartLine',
      colorHex: '#2196F3',
      isIncomeCategory: true,
      subcategories: [
        SubcategoryModel(
          id: 'sub15',
          name: 'Dividend',
          iconName: 'chartLine',
          categoryId: 'cat7',
        ),
        SubcategoryModel(
          id: 'sub16',
          name: 'Interest',
          iconName: 'percent',
          categoryId: 'cat7',
        ),
      ],
    ),
  ];

  // Dummy Transactions
  static final List<TransactionModel> _transactions = [
    // Recent transactions
    TransactionModel(
      id: _uuid.v4(),
      description: 'Coffee at Starbucks',
      amount: 45000,
      type: 'expense',
      categoryId: 'cat1',
      subcategoryId: 'sub1',
      paymentMethodId: 'pm2',
      date: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)).toIso8601String(),
    ),
    TransactionModel(
      id: _uuid.v4(),
      description: 'Lunch at restaurant',
      amount: 85000,
      type: 'expense',
      categoryId: 'cat1',
      subcategoryId: 'sub2',
      paymentMethodId: 'pm1',
      date: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
    ),
    TransactionModel(
      id: _uuid.v4(),
      description: 'Monthly Salary',
      amount: 8000000,
      type: 'income',
      categoryId: 'cat6',
      subcategoryId: 'sub13',
      paymentMethodId: 'pm3',
      date: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
    ),
    TransactionModel(
      id: _uuid.v4(),
      description: 'Fuel for car',
      amount: 120000,
      type: 'expense',
      categoryId: 'cat2',
      subcategoryId: 'sub4',
      paymentMethodId: 'pm1',
      date: DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
    ),
    TransactionModel(
      id: _uuid.v4(),
      description: 'Electricity bill',
      amount: 250000,
      type: 'expense',
      categoryId: 'cat5',
      subcategoryId: 'sub11',
      paymentMethodId: 'pm3',
      date: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
    ),
    TransactionModel(
      id: _uuid.v4(),
      description: 'Movie tickets',
      amount: 75000,
      type: 'expense',
      categoryId: 'cat3',
      subcategoryId: 'sub7',
      paymentMethodId: 'pm2',
      date: DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
    ),
    TransactionModel(
      id: _uuid.v4(),
      description: 'New shirt',
      amount: 150000,
      type: 'expense',
      categoryId: 'cat4',
      subcategoryId: 'sub9',
      paymentMethodId: 'pm4',
      date: DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      createdAt: DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
      updatedAt: DateTime.now().subtract(const Duration(days: 10)).toIso8601String(),
    ),
  ];

  // Dummy Budgets
  static final List<Budget> _budgets = [
    Budget(
      id: _uuid.v4(),
      categoryId: 'cat1',
      amount: 1000000,
      spent: 350000,
      startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      endDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Budget(
      id: _uuid.v4(),
      categoryId: 'cat2',
      amount: 500000,
      spent: 120000,
      startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      endDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Budget(
      id: _uuid.v4(),
      categoryId: 'cat3',
      amount: 300000,
      spent: 75000,
      startDate: DateTime(DateTime.now().year, DateTime.now().month, 1),
      endDate: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  // Getters
  static List<CategoryModel> get categories => List.unmodifiable(_categories);
  static List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  static List<PaymentMethod> get paymentMethods => List.unmodifiable(_paymentMethods);
  static List<Budget> get budgets => List.unmodifiable(_budgets);

  // Add methods
  static void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
  }

  static void updateTransaction(TransactionModel transaction) {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
    }
  }

  static void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
  }

  static void addBudget(Budget budget) {
    _budgets.add(budget);
  }

  static void updateBudget(Budget budget) {
    final index = _budgets.indexWhere((b) => b.id == budget.id);
    if (index != -1) {
      _budgets[index] = budget;
    }
  }

  static void deleteBudget(String id) {
    _budgets.removeWhere((b) => b.id == id);
  }
}

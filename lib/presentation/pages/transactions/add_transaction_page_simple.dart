import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../data/datasources/supabase_data_source.dart';
import '../../../core/di/injection.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/transaction/transaction_event.dart';
import '../../blocs/transaction/transaction_state.dart';

class AddTransactionPageSimple extends StatefulWidget {
  const AddTransactionPageSimple({super.key});

  @override
  State<AddTransactionPageSimple> createState() => _AddTransactionPageSimpleState();
}

class _AddTransactionPageSimpleState extends State<AddTransactionPageSimple> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  
  TransactionType _selectedType = TransactionType.expense;
  String _selectedCategory = '';
  DateTime _selectedDate = DateTime.now();

  List<CategoryItem> _categories = [];
  bool _isLoadingCategories = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Load categories from database
  Future<void> _loadCategories() async {
    try {
      final dataSource = getIt<SupabaseDataSource>();
      final categoriesFromDb = await dataSource.getAllCategories();
      
      if (categoriesFromDb.isNotEmpty) {
        setState(() {
          _categories = categoriesFromDb.map((cat) => CategoryItem(
            cat.id,
            cat.name,
            _getIconFromName(cat.iconName ?? 'category'),
            _getColorFromHex(cat.colorHex ?? '#64748B'),
          )).toList();
          _selectedCategory = _categories.first.id;
          _isLoadingCategories = false;
        });
      } else {
        // Fallback default categories
        setState(() {
          _categories = _getDefaultCategories();
          _selectedCategory = _categories.first.id;
          _isLoadingCategories = false;
        });
      }
    } catch (e) {
      setState(() {
        _categories = _getDefaultCategories();
        _selectedCategory = _categories.first.id;
        _isLoadingCategories = false;
      });
    }
  }

  // Get default categories as fallback
  List<CategoryItem> _getDefaultCategories() {
    return [
      CategoryItem('default-food', 'Food & Dining', Icons.restaurant, const Color(0xFFF59E0B)),
      CategoryItem('default-transport', 'Transportation', Icons.directions_car, const Color(0xFF06B6D4)),
      CategoryItem('default-entertainment', 'Entertainment', Icons.movie, const Color(0xFF8B5CF6)),
      CategoryItem('default-shopping', 'Shopping', Icons.shopping_bag, const Color(0xFFEC4899)),
      CategoryItem('default-salary', 'Salary', Icons.work, const Color(0xFF3B82F6)),
    ];
  }

  // Simple icon mapping
  IconData _getIconFromName(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'restaurant': case 'food': return Icons.restaurant;
      case 'directions_car': case 'transport': return Icons.directions_car;
      case 'movie': case 'entertainment': return Icons.movie;
      case 'shopping_bag': case 'shopping': return Icons.shopping_bag;
      case 'work': case 'salary': return Icons.work;
      case 'laptop': case 'freelance': return Icons.laptop;
      case 'trending_up': case 'investment': return Icons.trending_up;
      default: return Icons.category;
    }
  }

  // Simple color parsing
  Color _getColorFromHex(String hexColor) {
    try {
      String hex = hexColor.replaceAll('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return const Color(0xFF64748B);
    }
  }

  // Save transaction (simplified)
  void _saveTransaction() {
    if (_formKey.currentState!.validate() && _selectedCategory.isNotEmpty) {
      final amount = double.parse(_amountController.text);
      
      context.read<TransactionBloc>().add(AddTransactionEvent(
        description: _descriptionController.text,
        amount: amount,
        type: _selectedType,
        categoryId: _selectedCategory,
        subcategoryId: '${_selectedCategory}_sub', // Simple subcategory
        paymentMethodId: 'default-cash', // Default payment method
        date: _selectedDate,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionOperationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transaction saved successfully!'),
              backgroundColor: Color(0xFF10B981),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is TransactionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Transaction'),
          backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
        ),
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
        body: _isLoadingCategories
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Transaction Type Toggle
                      _buildTypeToggle(isDark),
                      const SizedBox(height: 20),

                      // Description Field
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Description',
                        hint: 'Enter transaction description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Amount Field
                      _buildTextField(
                        controller: _amountController,
                        label: 'Amount',
                        hint: 'Enter amount',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter valid amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Category Selection
                      _buildCategorySelection(isDark),
                      const SizedBox(height: 20),

                      // Date Selection
                      _buildDateSelection(isDark),
                      const SizedBox(height: 30),

                      // Save Button
                      _buildSaveButton(isDark),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTypeToggle(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3748) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeButton('Expense', TransactionType.expense, Colors.red),
          ),
          Expanded(
            child: _buildTypeButton('Income', TransactionType.income, Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String title, TransactionType type, Color color) {
    final isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              hint: const Text('Select Category'),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _selectedCategory = newValue);
                }
              },
              items: _categories.map<DropdownMenuItem<String>>((CategoryItem category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Row(
                    children: [
                      Icon(category.icon, color: category.color, size: 20),
                      const SizedBox(width: 8),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              setState(() => _selectedDate = picked);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 12),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveTransaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B5CF6),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Transaction',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// Simple category item model
class CategoryItem {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  CategoryItem(this.id, this.name, this.icon, this.color);
}

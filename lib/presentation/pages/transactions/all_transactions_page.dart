import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../blocs/transaction/transaction_bloc.dart';
import '../../blocs/transaction/transaction_state.dart';
import '../../blocs/transaction/transaction_event.dart';
import '../../../core/utils/date_time_helper.dart';
import '../../../core/utils/currency_formatter.dart';

class AllTransactionsPage extends StatefulWidget {
  const AllTransactionsPage({super.key});

  @override
  State<AllTransactionsPage> createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  TransactionType? _selectedType;
  String _sortBy = 'date'; // date, amount, category
  bool _sortAscending = false;
  
  @override
  void initState() {
    super.initState();
    // Load transactions if not already loaded
    context.read<TransactionBloc>().add(LoadTransactions());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh data when this page becomes active
    context.read<TransactionBloc>().add(LoadTransactions());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : const Color(0xFF1E293B),
          ),
        ),
        title: Text(
          'All Transactions',
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showSortOptions,
            icon: Icon(
              Icons.sort_rounded,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          IconButton(
            onPressed: _showFilterOptions,
            icon: Icon(
              Icons.filter_list_rounded,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(isDark),
          
          // Filter Chips
          if (_selectedType != null) _buildActiveFilters(isDark),
          
          // Transactions List
          Expanded(
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TransactionError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading transactions',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<TransactionBloc>().add(LoadTransactions());
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final allTransactions = state is TransactionLoaded ? state.transactions : <Transaction>[];
                final filteredTransactions = _filterAndSortTransactions(allTransactions);

                if (filteredTransactions.isEmpty && allTransactions.isNotEmpty) {
                  return _buildNoResultsFound(isDark);
                }

                if (allTransactions.isEmpty) {
                  return _buildEmptyState(isDark);
                }

                return _buildTransactionsList(filteredTransactions, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3748) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        decoration: InputDecoration(
          hintText: 'Search transactions...',
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: Icon(
                    Icons.clear_rounded,
                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        style: TextStyle(
          color: isDark ? Colors.white : const Color(0xFF1E293B),
        ),
      ),
    );
  }

  Widget _buildActiveFilters(bool isDark) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (_selectedType != null)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: Chip(
                label: Text(
                  _selectedType == TransactionType.income ? 'Income' : 'Expense',
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                    fontSize: 12,
                  ),
                ),
                deleteIcon: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
                onDeleted: () {
                  setState(() {
                    _selectedType = null;
                  });
                },
                backgroundColor: isDark ? const Color(0xFF2D3748) : Colors.white,
                side: BorderSide(
                  color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<Transaction> transactions, bool isDark) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<TransactionBloc>().add(LoadTransactions());
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: transactions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return _buildTransactionCard(transaction, isDark);
        },
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction, bool isDark) {
    final isIncome = transaction.type == TransactionType.income;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2D3748) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey).withOpacity(isDark ? 0.3 : 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Category Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getCategoryColor(transaction.categoryId).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(transaction.categoryId),
              color: _getCategoryColor(transaction.categoryId),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        _getCategoryName(transaction.categoryId),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (transaction.subcategoryId != null) ...[
                      Text(
                        ' • ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          transaction.subcategoryId!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${DateTimeHelper.formatDate(transaction.date)} • ${DateTimeHelper.formatTime(transaction.date)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.grey[500] : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // Amount
          SizedBox(
            width: 120, // Fixed width to prevent overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencyFormatter.formatAmountWithSign(transaction.amount, isIncome),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isIncome 
                        ? const Color(0xFF10B981).withOpacity(0.1)
                        : const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    isIncome ? 'Income' : 'Expense',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isIncome ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              size: 64,
              color: const Color(0xFF667EEA),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Transactions Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start tracking your finances by adding\nyour first transaction',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsFound(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 64,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Results Found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters\nto find what you\'re looking for',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
                _selectedType = null;
              });
            },
            child: Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D3748) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sort By',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 20),
              _buildSortOption('Date', 'date', Icons.calendar_today_rounded, isDark),
              _buildSortOption('Amount', 'amount', Icons.attach_money_rounded, isDark),
              _buildSortOption('Category', 'category', Icons.category_rounded, isDark),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Order:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ChoiceChip(
                    label: Text('Newest First'),
                    selected: !_sortAscending,
                    onSelected: (selected) {
                      setState(() {
                        _sortAscending = false;
                      });
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('Oldest First'),
                    selected: _sortAscending,
                    onSelected: (selected) {
                      setState(() {
                        _sortAscending = true;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String title, String value, IconData icon, bool isDark) {
    final isSelected = _sortBy == value;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected 
            ? const Color(0xFF667EEA)
            : (isDark ? Colors.grey[400] : Colors.grey[600]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected 
              ? const Color(0xFF667EEA)
              : (isDark ? Colors.white : const Color(0xFF1E293B)),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check_rounded, color: Color(0xFF667EEA)) : null,
      onTap: () {
        setState(() {
          _sortBy = value;
        });
        Navigator.pop(context);
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2D3748) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter By Type',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 20),
              _buildFilterOption('All', null, Icons.all_inclusive_rounded, isDark),
              _buildFilterOption('Income', TransactionType.income, Icons.trending_up_rounded, isDark),
              _buildFilterOption('Expense', TransactionType.expense, Icons.trending_down_rounded, isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title, TransactionType? type, IconData icon, bool isDark) {
    final isSelected = _selectedType == type;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected 
            ? const Color(0xFF667EEA)
            : (isDark ? Colors.grey[400] : Colors.grey[600]),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected 
              ? const Color(0xFF667EEA)
              : (isDark ? Colors.white : const Color(0xFF1E293B)),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check_rounded, color: Color(0xFF667EEA)) : null,
      onTap: () {
        setState(() {
          _selectedType = type;
        });
        Navigator.pop(context);
      },
    );
  }

  List<Transaction> _filterAndSortTransactions(List<Transaction> transactions) {
    List<Transaction> filtered = transactions;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((transaction) {
        return transaction.description.toLowerCase().contains(_searchQuery) ||
               _getCategoryName(transaction.categoryId).toLowerCase().contains(_searchQuery) ||
               (transaction.subcategoryId?.toLowerCase().contains(_searchQuery) ?? false);
      }).toList();
    }

    // Apply type filter
    if (_selectedType != null) {
      filtered = filtered.where((transaction) => transaction.type == _selectedType).toList();
    }

    // Apply sorting
    filtered.sort((a, b) {
      int comparison;
      switch (_sortBy) {
        case 'amount':
          comparison = a.amount.compareTo(b.amount);
          break;
        case 'category':
          comparison = _getCategoryName(a.categoryId).compareTo(_getCategoryName(b.categoryId));
          break;
        case 'date':
        default:
          comparison = a.date.compareTo(b.date);
          break;
      }
      return _sortAscending ? comparison : -comparison;
    });

    return filtered;
  }

  String _getCategoryName(String categoryId) {
    switch (categoryId) {
      case 'food':
        return 'Food & Dining';
      case 'transportation':
        return 'Transportation';
      case 'entertainment':
        return 'Entertainment';
      case 'shopping':
        return 'Shopping';
      case 'health':
        return 'Health';
      case 'salary':
        return 'Salary';
      case 'freelance':
        return 'Freelance';
      case 'investment':
        return 'Investment';
      default:
        return 'Other';
    }
  }

  Color _getCategoryColor(String categoryId) {
    switch (categoryId) {
      case 'food':
        return const Color(0xFFF59E0B);
      case 'transportation':
        return const Color(0xFF06B6D4);
      case 'entertainment':
        return const Color(0xFF8B5CF6);
      case 'shopping':
        return const Color(0xFFEC4899);
      case 'health':
        return const Color(0xFF10B981);
      case 'salary':
        return const Color(0xFF3B82F6);
      case 'freelance':
        return const Color(0xFF6366F1);
      case 'investment':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF64748B);
    }
  }

  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId) {
      case 'food':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'health':
        return Icons.local_hospital;
      case 'salary':
        return Icons.work;
      case 'freelance':
        return Icons.laptop;
      case 'investment':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

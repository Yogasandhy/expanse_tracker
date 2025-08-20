import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';
import '../../core/error/failures.dart';

abstract class SupabaseDataSource {
  // Transactions
  Future<List<TransactionModel>> getAllTransactions();
  Future<TransactionModel> getTransactionById(String id);
  Future<TransactionModel> addTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
  
  // Categories
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> getCategoryById(String id);
  Future<CategoryModel> addCategory(CategoryModel category);
  Future<CategoryModel> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String id);
}

@LazySingleton(as: SupabaseDataSource)
class SupabaseDataSourceImpl implements SupabaseDataSource {
  final SupabaseClient _supabaseClient;
  
  SupabaseDataSourceImpl(this._supabaseClient);
  
  // Transaction methods
  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      print('🔍 SupabaseDataSource: Fetching all transactions...');
      final response = await _supabaseClient
          .from('transactions')
          .select()
          .order('date', ascending: false);
      
      print('📦 SupabaseDataSource: Response received: ${response.length} items');
      print('🔍 Raw data sample: ${response.isNotEmpty ? response.first : "No data"}');
      
      final transactions = <TransactionModel>[];
      for (int i = 0; i < response.length; i++) {
        try {
          final json = response[i];
          print('🔍 Processing item $i: ${json.keys}');
          final transaction = TransactionModel.fromJson(json);
          transactions.add(transaction);
        } catch (e) {
          print('❌ Error parsing item $i: $e');
          print('📦 Raw item $i: ${response[i]}');
        }
      }
          
      print('✅ SupabaseDataSource: Mapped to ${transactions.length} TransactionModel');
      return transactions;
    } catch (e) {
      print('❌ SupabaseDataSource Error: ${e.toString()}');
      throw DatabaseFailure('Failed to get transactions: ${e.toString()}');
    }
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    try {
      final response = await _supabaseClient
          .from('transactions')
          .select()
          .eq('id', id)
          .single();
      
      return TransactionModel.fromJson(response);
    } catch (e) {
      throw DatabaseFailure('Failed to get transaction by id: ${e.toString()}');
    }
  }

  @override
  Future<TransactionModel> addTransaction(TransactionModel transaction) async {
    try {
      print('🎯 [SupabaseDataSource] Starting addTransaction...');
      print('📋 [SupabaseDataSource] Transaction data to insert:');
      print('   - ID: ${transaction.id}');
      print('   - Description: ${transaction.description}');
      print('   - Amount: ${transaction.amount}');
      print('   - Type: ${transaction.type}');
      print('   - Category: ${transaction.categoryId}');
      print('   - Date: ${transaction.date}');
      
      final jsonData = transaction.toJson();
      print('🗂️ [SupabaseDataSource] JSON payload: $jsonData');
      
      print('📤 [SupabaseDataSource] Sending to Supabase...');
      final response = await _supabaseClient
          .from('transactions')
          .insert(jsonData)
          .select()
          .single();
      
      print('✅ [SupabaseDataSource] Supabase response received!');
      print('📥 [SupabaseDataSource] Response data: $response');
      
      final result = TransactionModel.fromJson(response);
      print('🎉 [SupabaseDataSource] Transaction successfully saved with ID: ${result.id}');
      
      return result;
    } catch (e) {
      print('💥 [SupabaseDataSource] ERROR adding transaction: ${e.toString()}');
      print('🔍 [SupabaseDataSource] Error type: ${e.runtimeType}');
      throw DatabaseFailure('Failed to add transaction: ${e.toString()}');
    }
  }

  @override
  Future<TransactionModel> updateTransaction(TransactionModel transaction) async {
    try {
      final response = await _supabaseClient
          .from('transactions')
          .update(transaction.toJson())
          .eq('id', transaction.id)
          .select()
          .single();
      
      return TransactionModel.fromJson(response);
    } catch (e) {
      throw DatabaseFailure('Failed to update transaction: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTransaction(String id) async {
    try {
      await _supabaseClient
          .from('transactions')
          .delete()
          .eq('id', id);
    } catch (e) {
      throw DatabaseFailure('Failed to delete transaction: ${e.toString()}');
    }
  }

  // Category methods
  @override
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      print('🔍 SupabaseDataSource: Fetching all categories...');
      final response = await _supabaseClient
          .from('categories')
          .select()
          .order('name', ascending: true);
      
      print('📦 SupabaseDataSource: Categories response: ${response.length} items');
      
      final categories = (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
          
      print('✅ SupabaseDataSource: Mapped to ${categories.length} CategoryModel');
      return categories;
    } catch (e) {
      print('❌ SupabaseDataSource Categories Error: ${e.toString()}');
      throw DatabaseFailure('Failed to get categories: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel> getCategoryById(String id) async {
    try {
      final response = await _supabaseClient
          .from('categories')
          .select()
          .eq('id', id)
          .single();
      
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw DatabaseFailure('Failed to get category by id: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel> addCategory(CategoryModel category) async {
    try {
      final response = await _supabaseClient
          .from('categories')
          .insert(category.toJson())
          .select()
          .single();
      
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw DatabaseFailure('Failed to add category: ${e.toString()}');
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      final response = await _supabaseClient
          .from('categories')
          .update(category.toJson())
          .eq('id', category.id)
          .select()
          .single();
      
      return CategoryModel.fromJson(response);
    } catch (e) {
      throw DatabaseFailure('Failed to update category: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _supabaseClient
          .from('categories')
          .delete()
          .eq('id', id);
    } catch (e) {
      throw DatabaseFailure('Failed to delete category: ${e.toString()}');
    }
  }
}

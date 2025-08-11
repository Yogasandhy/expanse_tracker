import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/usecases/transaction_usecases.dart' as usecases;
import '../../../domain/usecases/usecase.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final usecases.GetAllTransactions _getAllTransactions;
  final usecases.GetTransactionsByDateRange _getTransactionsByDateRange;
  final usecases.GetTransactionsByCategory _getTransactionsByCategory;
  final usecases.AddTransaction _addTransaction;
  final usecases.UpdateTransaction _updateTransaction;
  final usecases.DeleteTransaction _deleteTransaction;
  final usecases.SearchTransactions _searchTransactions;

  static const _uuid = Uuid();

  TransactionBloc(
    this._getAllTransactions,
    this._getTransactionsByDateRange,
    this._getTransactionsByCategory,
    this._addTransaction,
    this._updateTransaction,
    this._deleteTransaction,
    this._searchTransactions,
  ) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<LoadTransactionsByDateRange>(_onLoadTransactionsByDateRange);
    on<LoadTransactionsByCategory>(_onLoadTransactionsByCategory);
    on<AddTransactionEvent>(_onAddTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<SearchTransactions>(_onSearchTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await _getAllTransactions(NoParams());

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (transactions) => emit(TransactionLoaded(transactions: transactions)),
    );
  }

  Future<void> _onLoadTransactionsByDateRange(
    LoadTransactionsByDateRange event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await _getTransactionsByDateRange(
      usecases.GetTransactionsByDateRangeParams(
        startDate: event.startDate,
        endDate: event.endDate,
      ),
    );

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (transactions) => emit(TransactionLoaded(transactions: transactions)),
    );
  }

  Future<void> _onLoadTransactionsByCategory(
    LoadTransactionsByCategory event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await _getTransactionsByCategory(
      usecases.GetTransactionsByCategoryParams(categoryId: event.categoryId),
    );

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (transactions) => emit(TransactionLoaded(transactions: transactions)),
    );
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final now = DateTime.now();
    final transaction = Transaction(
      id: _uuid.v4(),
      description: event.description,
      amount: event.amount,
      type: event.type,
      categoryId: event.categoryId,
      subcategoryId: event.subcategoryId,
      paymentMethodId: event.paymentMethodId,
      date: event.date,
      createdAt: now,
      updatedAt: now,
    );

    final result = await _addTransaction(
      usecases.AddTransactionParams(transaction: transaction),
    );

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (addedTransaction) async {
        // Reload transactions after adding
        final reloadResult = await _getAllTransactions(NoParams());
        reloadResult.fold(
          (failure) => emit(TransactionError(message: failure.message)),
          (transactions) => emit(TransactionOperationSuccess(
            message: 'Transaction added successfully',
            transactions: transactions,
          )),
        );
      },
    );
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await _updateTransaction(
      usecases.UpdateTransactionParams(transaction: event.transaction),
    );

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (updatedTransaction) async {
        // Reload transactions after updating
        final reloadResult = await _getAllTransactions(NoParams());
        reloadResult.fold(
          (failure) => emit(TransactionError(message: failure.message)),
          (transactions) => emit(TransactionOperationSuccess(
            message: 'Transaction updated successfully',
            transactions: transactions,
          )),
        );
      },
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await _deleteTransaction(
      usecases.DeleteTransactionParams(id: event.id),
    );

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (_) async {
        // Reload transactions after deleting
        final reloadResult = await _getAllTransactions(NoParams());
        reloadResult.fold(
          (failure) => emit(TransactionError(message: failure.message)),
          (transactions) => emit(TransactionOperationSuccess(
            message: 'Transaction deleted successfully',
            transactions: transactions,
          )),
        );
      },
    );
  }

  Future<void> _onSearchTransactions(
    SearchTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());

    final result = await _searchTransactions(
      usecases.SearchTransactionsParams(query: event.query),
    );

    result.fold(
      (failure) => emit(TransactionError(message: failure.message)),
      (transactions) => emit(TransactionLoaded(transactions: transactions)),
    );
  }
}

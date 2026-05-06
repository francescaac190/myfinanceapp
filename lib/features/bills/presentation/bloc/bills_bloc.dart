import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfinanceapp/core/api/api_exception.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills.dart';
import 'package:myfinanceapp/features/bills/domain/entities/bills_summary.dart';
import 'package:myfinanceapp/features/bills/domain/repositories/bills_repository.dart';

String _errorMessage(Object err) => err is ApiException
    ? err.message
    : 'Something went wrong. Please try again.';

sealed class BillsEvent extends Equatable {
  const BillsEvent();

  @override
  List<Object?> get props => [];
}

class BillsRequested extends BillsEvent {
  const BillsRequested({this.status});
  final String? status;

  @override
  List<Object?> get props => [status];
}

class BillsRefreshRequested extends BillsEvent {
  const BillsRefreshRequested();
}

class BillsLoadMoreRequested extends BillsEvent {
  const BillsLoadMoreRequested();
}

class BillsFilterChanged extends BillsEvent {
  const BillsFilterChanged(this.status);
  final String? status;

  @override
  List<Object?> get props => [status];
}

class BillCreated extends BillsEvent {
  const BillCreated(this.input);
  final CreateBillsRequest input;

  @override
  List<Object?> get props => [input];
}

class BillUpdated extends BillsEvent {
  const BillUpdated(this.id, this.input);
  final String id;
  final UpdateBillsInput input;

  @override
  List<Object?> get props => [id, input];
}

class BillDeleted extends BillsEvent {
  const BillDeleted(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}

class BillPaid extends BillsEvent {
  const BillPaid(this.id, {this.accountId, this.paidAt});
  final String id;
  final String? accountId;
  final DateTime? paidAt;

  @override
  List<Object?> get props => [id, accountId, paidAt];
}

enum BillsStatus { initial, loading, success, failure }

enum BillsActionStatus { idle, inProgress, success, failure }

class BillsState extends Equatable {
  const BillsState({
    this.status = BillsStatus.initial,
    this.actionStatus = BillsActionStatus.idle,
    this.bills = const [],
    this.summary,
    this.filter,
    this.nextCursor,
    this.hasMore = false,
    this.errorMessage,
    this.actionMessage,
  });

  final BillsStatus status;
  final BillsActionStatus actionStatus;
  final List<Bills> bills;
  final BillsSummary? summary;
  final String? filter;
  final String? nextCursor;
  final bool hasMore;
  final String? errorMessage;
  final String? actionMessage;

  BillsState copyWith({
    BillsStatus? status,
    BillsActionStatus? actionStatus,
    List<Bills>? bills,
    BillsSummary? summary,
    String? filter,
    String? nextCursor,
    bool? hasMore,
    String? errorMessage,
    String? actionMessage,
    bool clearFilter = false,
    bool clearError = false,
    bool clearActionMessage = false,
  }) {
    return BillsState(
      status: status ?? this.status,
      actionStatus: actionStatus ?? this.actionStatus,
      bills: bills ?? this.bills,
      summary: summary ?? this.summary,
      filter: clearFilter ? null : (filter ?? this.filter),
      nextCursor: nextCursor ?? this.nextCursor,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      actionMessage:
          clearActionMessage ? null : (actionMessage ?? this.actionMessage),
    );
  }

  @override
  List<Object?> get props => [
        status,
        actionStatus,
        bills,
        summary,
        filter,
        nextCursor,
        hasMore,
        errorMessage,
        actionMessage,
      ];
}

class BillsBloc extends Bloc<BillsEvent, BillsState> {
  BillsBloc(this._repo) : super(const BillsState()) {
    on<BillsRequested>(_onRequested);
    on<BillsRefreshRequested>(_onRefresh);
    on<BillsLoadMoreRequested>(_onLoadMore);
    on<BillsFilterChanged>(_onFilterChanged);
    on<BillCreated>(_onCreated);
    on<BillUpdated>(_onUpdated);
    on<BillDeleted>(_onDeleted);
    on<BillPaid>(_onPaid);
  }

  final BillsRepository _repo;

  Future<void> _load(
    Emitter<BillsState> emit, {
    String? filter,
    bool clearFilter = false,
  }) async {
    emit(
      state.copyWith(
        status: BillsStatus.loading,
        clearError: true,
      ),
    );
    try {
      final result = await _repo.list(status: filter);
      final summary = await _repo.getSummary();
      emit(
        state.copyWith(
          status: BillsStatus.success,
          bills: result.data,
          nextCursor: result.nextCursor,
          hasMore: result.nextCursor != null,
          summary: summary,
          filter: filter,
          clearFilter: clearFilter,
        ),
      );
    } catch (err) {
      emit(
        state.copyWith(
          status: BillsStatus.failure,
          errorMessage: _errorMessage(err),
        ),
      );
    }
  }

  Future<void> _onRequested(
    BillsRequested event,
    Emitter<BillsState> emit,
  ) =>
      _load(emit, filter: event.status ?? state.filter);

  Future<void> _onRefresh(
    BillsRefreshRequested event,
    Emitter<BillsState> emit,
  ) =>
      _load(emit, filter: state.filter);

  Future<void> _onFilterChanged(
    BillsFilterChanged event,
    Emitter<BillsState> emit,
  ) =>
      _load(emit, filter: event.status, clearFilter: event.status == null);

  Future<void> _onLoadMore(
    BillsLoadMoreRequested event,
    Emitter<BillsState> emit,
  ) async {
    if (!state.hasMore || state.status == BillsStatus.loading) return;
    try {
      final result = await _repo.list(
        cursor: state.nextCursor,
        status: state.filter,
      );
      emit(
        state.copyWith(
          bills: [...state.bills, ...result.data],
          nextCursor: result.nextCursor,
          hasMore: result.nextCursor != null,
        ),
      );
    } catch (err) {
      emit(state.copyWith(errorMessage: _errorMessage(err)));
    }
  }

  Future<void> _runAction(
    Emitter<BillsState> emit,
    Future<void> Function() action, {
    String? successMessage,
  }) async {
    emit(
      state.copyWith(
        actionStatus: BillsActionStatus.inProgress,
        clearError: true,
        clearActionMessage: true,
      ),
    );
    try {
      await action();
      emit(
        state.copyWith(
          actionStatus: BillsActionStatus.success,
          actionMessage: successMessage,
        ),
      );
      await _load(emit, filter: state.filter);
    } catch (err) {
      emit(
        state.copyWith(
          actionStatus: BillsActionStatus.failure,
          errorMessage: _errorMessage(err),
        ),
      );
    }
  }

  Future<void> _onCreated(BillCreated event, Emitter<BillsState> emit) =>
      _runAction(
        emit,
        () async {
          await _repo.create(event.input);
        },
        successMessage: 'Bill created',
      );

  Future<void> _onUpdated(BillUpdated event, Emitter<BillsState> emit) =>
      _runAction(
        emit,
        () async {
          await _repo.update(event.id, event.input);
        },
        successMessage: 'Bill updated',
      );

  Future<void> _onDeleted(BillDeleted event, Emitter<BillsState> emit) =>
      _runAction(
        emit,
        () => _repo.delete(event.id),
        successMessage: 'Bill deleted',
      );

  Future<void> _onPaid(BillPaid event, Emitter<BillsState> emit) => _runAction(
        emit,
        () => _repo.payBill(event.id, {
          if (event.accountId != null) 'accountId': event.accountId,
          if (event.paidAt != null) 'paidAt': event.paidAt!.toIso8601String(),
        }),
        successMessage: 'Bill marked as paid',
      );
}

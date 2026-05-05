import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfinanceapp/core/api/api_exception.dart';
import 'package:myfinanceapp/features/home/domain/entities/home_overview_entity.dart';
import 'package:myfinanceapp/features/home/domain/repositories/home_overview_repository.dart';

String _errorMessage(Object err) => err is ApiException
    ? err.message
    : 'Something went wrong. Please try again.';

sealed class HomeOverviewEvent extends Equatable {
  const HomeOverviewEvent();

  @override
  List<Object?> get props => [];
}

class HomeOverviewRequested extends HomeOverviewEvent {
  const HomeOverviewRequested();
}

class HomeOverviewRefreshRequested extends HomeOverviewEvent {
  const HomeOverviewRefreshRequested();
}

sealed class HomeOverviewState extends Equatable {
  const HomeOverviewState();

  @override
  List<Object?> get props => [];
}

class HomeOverviewInitial extends HomeOverviewState {
  const HomeOverviewInitial();
}

class HomeOverviewLoading extends HomeOverviewState {
  const HomeOverviewLoading();
}

class HomeOverviewLoaded extends HomeOverviewState {
  const HomeOverviewLoaded(this.overview);

  final HomeOverview overview;

  @override
  List<Object?> get props => [overview];
}

class HomeOverviewFailure extends HomeOverviewState {
  const HomeOverviewFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class HomeOverviewBloc extends Bloc<HomeOverviewEvent, HomeOverviewState> {
  HomeOverviewBloc(this._repository) : super(const HomeOverviewInitial()) {
    on<HomeOverviewRequested>(_onRequested);
    on<HomeOverviewRefreshRequested>(_onRefreshRequested);
  }

  final HomeOverviewRepository _repository;

  Future<void> _onRequested(
    HomeOverviewRequested event,
    Emitter<HomeOverviewState> emit,
  ) async {
    emit(const HomeOverviewLoading());
    await _loadOverview(emit);
  }

  Future<void> _onRefreshRequested(
    HomeOverviewRefreshRequested event,
    Emitter<HomeOverviewState> emit,
  ) async {
    await _loadOverview(emit);
  }

  Future<void> _loadOverview(Emitter<HomeOverviewState> emit) async {
    try {
      final overview = await _repository.getHomeOverview();
      emit(HomeOverviewLoaded(overview));
    } catch (err) {
      emit(HomeOverviewFailure(_errorMessage(err)));
    }
  }
}

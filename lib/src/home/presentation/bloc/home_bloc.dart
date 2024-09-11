import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suricato_app/src/home/entities/movie.dart';

import '../../domain/usecases/get_my_movies.dart';
import '../../failures/failures.dart';
part 'home_event.dart';
part 'home_state.dart';

class MyMoviesBloc extends Bloc<MyMoviesEvent, MyMoviesState> {
  final GetMyMovies getMyMovies;

  MyMoviesBloc(this.getMyMovies) : super(MyMoviesInitial()) {
    on<GetMyMoviesEvent>(_getMyMovies);
  }

  FutureOr<void> _getMyMovies(
    GetMyMoviesEvent event,
    Emitter<MyMoviesState> emit,
  ) async {
    emit(LoadingMoviesState());
    final result = await getMyMovies();
    result.fold(
      (failure) => emit(ErrorMoviesState(failure)),
      (movie) => emit(ResultMoviesState(movie)),
    );
  }
}

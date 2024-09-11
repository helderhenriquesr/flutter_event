part of 'home_bloc.dart';

abstract class MyMoviesState {}

class MyMoviesInitial extends MyMoviesState {}

class LoadingMoviesState extends MyMoviesState {}

class ResultMoviesState extends MyMoviesState {
  final Movie movie;
  ResultMoviesState(this.movie);
}

class ErrorMoviesState extends MyMoviesState {
  final MoviesFailure error;

  ErrorMoviesState(this.error);
}

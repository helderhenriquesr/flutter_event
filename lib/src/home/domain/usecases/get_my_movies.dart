import 'package:dartz/dartz.dart';
import '../../entities/movie.dart';
import '../repositories/home_repository_interface.dart';
import '../../failures/failures.dart';

class GetMyMovies {
  final HomeRepositoryInterface repository;

  const GetMyMovies(this.repository);

  Future<Either<MoviesFailure, Movie>> call() => repository.getMyMovies();
}

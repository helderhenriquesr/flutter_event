import 'package:dartz/dartz.dart';
import 'package:suricato_app/src/home/entities/movie.dart';
import '../../failures/failures.dart';

abstract class HomeRepositoryInterface {
  Future<Either<MoviesFailure, Movie>> getMyMovies();
}

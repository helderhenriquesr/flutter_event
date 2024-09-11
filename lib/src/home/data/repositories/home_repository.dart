import 'package:dartz/dartz.dart';
import 'package:suricato_app/src/home/entities/movie.dart';

import 'package:suricato_app/src/home/failures/failures.dart';

import '../../domain/repositories/home_repository_interface.dart';
import '../datasources/home_data_source.dart';

class HomeRepository implements HomeRepositoryInterface {
  final HomeDataSourceInterface dataSource;

  const HomeRepository(this.dataSource);

  @override
  Future<Either<MoviesFailure, Movie>> getMyMovies() =>
      dataSource.getMyMovies();
}

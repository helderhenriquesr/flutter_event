import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:suricato_app/src/home/entities/movie.dart';

import '../../../services/http_adapter.dart';
import '../../failures/failures.dart';
import '../../failures/http_failure.dart';
import 'package:http/http.dart' as http;

abstract class HomeDataSourceInterface {
  Future<Either<MoviesFailure, Movie>> getMyMovies();
}

class HomeDataSource implements HomeDataSourceInterface {
  final HttpAdapter httpAdapter;

  HomeDataSource({
    required this.httpAdapter,
  });

  @override
  Future<Either<MoviesFailure, Movie>> getMyMovies() async {
    try {
      // var resp = await httpAdapter.request(
      //   method: HttpMethod.get,
      //   path: 'movies/1',
      // );
      final resp = await http.get(Uri.parse('http://localhost:3000/movies/1'));

      if (resp.statusCode == HttpStatus.ok && resp.body != null) {
        final movie = Movie.fromJson(resp.body as Map<String, dynamic>);
        return right(movie);
      }
      return left(
        MovieFailure(
          message: 'Algo deu errado.',
        ),
      );
    } on HttpFailure catch (e) {
      return left(
        MovieFailure(
          message: e.message.toString(),
        ),
      );
    } catch (e) {
      // return left(
      //   MovieFailure(message: 'Algo deu errado.'),
      // );
      Map<String, String> movie = {
        'name': 'The Matrix',
        'director': 'The Wachowskis'
      };
      return right(Movie.fromJson(movie));
    }
  }
}

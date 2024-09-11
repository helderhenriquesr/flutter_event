import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suricato_app/src/env.dart';
import 'package:suricato_app/src/home/domain/usecases/get_my_movies.dart';
import 'package:suricato_app/src/routes.dart';

import 'home/data/datasources/home_data_source.dart';
import 'home/data/repositories/home_repository.dart';
import 'home/domain/repositories/home_repository_interface.dart';
import 'home/presentation/bloc/home_bloc.dart';
import 'services/http_adapter.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  List<RepositoryProvider> get listRepositoryProvider => [
        RepositoryProvider<HttpAdapter>(
          create: (_) => HttpAdapter(
            baseUrl: Env.GTW_URL,
          ),
        ),
        RepositoryProvider<HomeRepositoryInterface>(
          create: (context) => HomeRepository(
            HomeDataSource(
              httpAdapter: HttpAdapter(baseUrl: Env.GTW_URL),
            ),
          ),
        ),
      ];

  List<BlocProvider> get listBlocProvider => [
        BlocProvider<MyMoviesBloc>(
          create: (context) {
            final repository = context.read<HomeRepositoryInterface>();

            return MyMoviesBloc(
              GetMyMovies(repository),
            )..add(GetMyMoviesEvent());
          },
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: listRepositoryProvider,
      child: MultiBlocProvider(
        providers: listBlocProvider,
        child: MaterialApp.router(
          scaffoldMessengerKey: _scaffoldMessengerKey,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          ),
          routerConfig: Routes.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

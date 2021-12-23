// ignore_for_file: prefer_const_constructors

import 'package:breaking_bad/constants/const_strings.dart';
import 'package:breaking_bad/data/api/api_serves.dart';
import 'package:breaking_bad/data/model/character_model.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';
import 'package:breaking_bad/logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/ui/screens/characters_home_page.dart';
import 'package:breaking_bad/ui/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRoute() {
    characterRepository = CharacterRepository(CharacterAPI());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generatRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRouter:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersHomePage(),
          ),
        );
      case detailsRouter:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(characterRepository),
            child: DetailsScreen(characterM: character),
          ),
        );
    }
  }
}

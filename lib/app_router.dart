import 'package:flutter/material.dart';
import 'package:flutter_api/bloc_layer/cubit/characters_cubit.dart';
import 'package:flutter_api/data/model/chracter.dart';
import 'package:flutter_api/data/reposiotry/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/string.dart';
import 'data/web_servies/characters_web_services.dart';
import 'presentation/screens/characters.dart';
import 'presentation/screens/characters_detail.dart';

class AppRouter {
  late CharactersRepository characterRepository;
  late CharactersCubit characterCubit;

  AppRouter() {
    characterRepository = CharactersRepository(CharactersWebServices());
    characterCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characters:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: CharactersScreen(),
                ));
      case charactersDetailesScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(characterRepository),
            child: CharactersDetailesScreen(character: character),
          ),
        );
    }
    return null;
  }
}

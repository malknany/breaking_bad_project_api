import 'package:bloc/bloc.dart';
import 'package:flutter_api/data/model/character_quotes.dart';
import 'package:flutter_api/data/model/chracter.dart';
import 'package:flutter_api/data/reposiotry/characters_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((value) {
      emit(CharactersLoaded(value));
      characters = value;
    });
    return characters;
  }

  void getCharactersQuotes(String charName) {
    charactersRepository.getCharactersQuotes(charName).then((qoute) {
      emit(QuoteLoaded(qoute));
    });
  }
}

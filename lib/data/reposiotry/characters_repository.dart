import 'package:flutter_api/data/model/character_quotes.dart';
import 'package:flutter_api/data/model/chracter.dart';
import 'package:flutter_api/data/web_servies/characters_web_services.dart';

class CharactersRepository{
  final CharactersWebServices charactersWebServices;
  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters()async{
   final characters =await charactersWebServices.getAllCharacters();
   return characters.map((e) => Character.fromJson(e)).toList();
  }

  Future<List<Quotes>> getCharactersQuotes(String charName)async{
   final qoutes =await charactersWebServices.getCharactersQuotes(charName);
   return qoutes.map((e) => Quotes.fromJson(e)).toList();
  }
}
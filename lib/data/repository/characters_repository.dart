import 'package:breaking_bad/data/api/api_serves.dart';
import 'package:breaking_bad/data/model/character_model.dart';
import 'package:breaking_bad/data/model/quotes.dart';

class CharacterRepository {
  final CharacterAPI characterAPI;
  CharacterRepository(this.characterAPI);

  Future<List<CharacterModel>> fachCharacterData() async {
    final characters = await characterAPI.getAllCharacters();

    return characters
        .map((character) => CharacterModel.fromJson(character))
        .toList();
  }

  Future<List<Quotes>> getCharacterQuotes(String charName) async {
    final quotes = await characterAPI.getCharacterQuotes(charName);

    return quotes.map((quote) => Quotes.fromJson(quote)).toList();
  }
}

// ignore_for_file: unnecessary_this

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:breaking_bad/data/model/character_model.dart';
import 'package:breaking_bad/data/model/quotes.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<CharacterModel> characters = [];

  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<CharacterModel> getAllCharacters() {
    characterRepository.fachCharacterData().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getAllQuotes(String charName) {
    characterRepository.getCharacterQuotes(charName).then((quote) {
      emit(QuoteLoaded(quote));
    });
  }
}

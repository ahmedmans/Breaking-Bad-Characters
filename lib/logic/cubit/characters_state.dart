part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterModel> charactersMod;
  CharactersLoaded(this.charactersMod);
}

class QuoteLoaded extends CharactersState {
  final List<Quotes> quotes;
  QuoteLoaded(this.quotes);
}

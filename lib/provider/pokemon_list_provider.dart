import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/models/pokemon_list_model.dart';
import 'package:http/http.dart' as http;

class PokemonListProvider extends ChangeNotifier {
  bool isLoading = false;
  PokemonListModel? _pokemonList;
  PokemonListModel? get pokemonList => _pokemonList;

  PokemonDetailModel? _pokemonDetail;
  PokemonDetailModel? get pokemonDetail => _pokemonDetail;

  Future<void> getPokemonList() async {
    isLoading = true;
    notifyListeners();

    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/'));

    _pokemonList = pokemonListModelFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }

  setUrl(String url) async {
    final response = await http.get(Uri.parse(url));
    _pokemonDetail = pokemonDetailModelFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }
}

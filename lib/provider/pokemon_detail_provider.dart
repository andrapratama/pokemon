import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:http/http.dart' as http;

class PokemonDetailProvider extends ChangeNotifier {
  bool isLoading = false;
  PokemonDetailModel? _pokemonDetail;
  PokemonDetailModel? get pokemonDetail => _pokemonDetail;

  Future<void> getPokemonDetail(url) async {
    isLoading = true;
    // notifyListeners();

    final response = await http.get(Uri.parse(url));

    _pokemonDetail = pokemonDetailModelFromJson(response.body);
    isLoading = false;
    notifyListeners();
  }

  // setUrl(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //   _pokemonDetail = pokemonDetailModelFromJson(response.body);
  //   isLoading = false;
  //   notifyListeners();
  // }
}

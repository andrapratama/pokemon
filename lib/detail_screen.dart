import 'package:flutter/material.dart';
import 'package:pokemon/provider/pokemon_detail_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Consumer<PokemonDetailProvider>(
        builder: (BuildContext context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Column(
              children: [
                Text(value.pokemonDetail!.name),
                Image.network(value.pokemonDetail!.sprites.backDefault),
              ],
            ),
          );
        },
      ),
    );
  }
}

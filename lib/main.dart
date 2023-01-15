import 'package:flutter/material.dart';
import 'package:pokemon/detail_screen.dart';
import 'package:pokemon/models/pokemon_list_model.dart';
import 'package:pokemon/provider/pokemon_detail_provider.dart';
import 'package:pokemon/provider/pokemon_list_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonListProvider()..getPokemonList(),
        ),
        ChangeNotifierProvider(create: (_) => PokemonDetailProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Pokemon'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Result> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<PokemonListProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            primary: true,
            itemCount: value.pokemonList!.results!.length,
            itemBuilder: (BuildContext content, int index) {
              var result = value.pokemonList!.results;
              String pokemonName = result![index]!.name.toString();
              String pokemonUrl = result[index]!.url.toString();

              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        url: pokemonUrl,
                      );
                    },
                  );
                },
                child: Card(
                  color: const Color.fromARGB(255, 246, 247, 252),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          pokemonName,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  final String url;
  const BottomSheet({super.key, required this.url});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    Provider.of<PokemonListProvider>(context, listen: false).getPokemonList();

    return Consumer<PokemonDetailProvider>(
      builder: (BuildContext context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Text(value.pokemonDetail!.name),
            Image.network(value.pokemonDetail!.sprites.backDefault),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailScreen(),
                  ),
                );
              },
              child: const Text('Show More'),
            ),
          ],
        );
      },
    );
  }
}

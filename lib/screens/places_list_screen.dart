import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer<GreatPlaces>(
            child: const Center(
              child: Text('Got no places yet, start adding some!'),
            ),
            builder: (ctx, greatPlaces, ch) {
              if (ch == null) {
                return const Center(
                  child: Text('Got no places yet, start adding some!'),
                );
              }

              if (greatPlaces.itemsCount == 0) {
                return ch;
              }

              return ListView.builder(
                itemCount: greatPlaces.itemsCount,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[i].image),
                  ),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () => {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}

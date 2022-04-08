import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cofee_brew_1/models/brew.dart';
import 'package:cofee_brew_1/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>>(context) ?? [];
    //print(brews.docs);

        return ListView.builder(
          itemCount: brews.length,
          itemBuilder: (context, index){
            return BrewTile(brew: brews[index]);
          }
        );
  }
}

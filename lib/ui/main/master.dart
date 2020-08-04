import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterScreen extends StatelessWidget {
  MasterScreen({
    @required this.itemSelectedCallback,
    this.shows,
    this.selectedShow,
  });

  final ValueChanged<Show> itemSelectedCallback;
  final Show selectedShow;
  final List<Show> shows;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: ListView(
            children:
            shows.map((show) {
              return ListTile(
                title: Text(show.title),
                onTap: () => itemSelectedCallback(show),
                selected: selectedShow == show,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

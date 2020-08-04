import 'package:bomb_watch/data/api_responses/gb_shows.dart';
import 'package:bomb_watch/http/gb_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({@required this.show, this.gbClient});
  final Show show;

  GbClient gbClient;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          show?.title ?? 'Nutto selected',
          style: textTheme.subtitle1,
        ),
        Text(
          show?.deck ?? 'You mus selec',
          style: textTheme.subtitle2,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(show.title),
      ),
      body: Center(child: content),
    );
  }
}
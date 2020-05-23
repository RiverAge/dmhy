import 'package:dmhy/model/torrent/torrent.dart';
import 'package:flutter/material.dart';

/// 种子文字描述
class TorrentDescription extends StatelessWidget {
  final Torrent torrent;

  TorrentDescription({@required this.torrent}) : assert(torrent != null);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('${this.torrent.title} 引用'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) => ListTile(
          title: Text(this.torrent.references[i]),
        ),
        itemCount: this.torrent.references.length,
      ));
}

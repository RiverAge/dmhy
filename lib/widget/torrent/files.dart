// 正在做种
import 'package:dmhy/bloc/authenticate/authenticate.dart';
import 'package:dmhy/bloc/torrent/files.dart';
import 'package:dmhy/event/torrent/files.dart';
import 'package:dmhy/model/torrent/file.dart';
import 'package:dmhy/state/authenticate/authenticate.dart';
import 'package:dmhy/state/torrent/files.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Files extends StatelessWidget {
  final String tid;

  Files({@required this.tid}) : assert(tid != null);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticateBloc, AuthenticateState>(
          builder: (context, state) => state is AuthenticationAuthenticated
              ? BlocProvider(
                  create: (context) =>
                      FilesBloc()..add(Fetch(token: state.token, tid: tid)),
                  child: _Files(),
                )
              : null);
}

class _Files extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<FilesBloc, FilesState>(
        builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text('文件列表'),
            ),
            body: state is FilesLoaded
                ? ListView.builder(
                    itemBuilder: (context, index) =>
                        _FileItem(file: state.files[index]),
                    itemCount: state.files.length,
                  )
                : null),
      );
}

class _FileItem extends StatelessWidget {
  final File file;

  _FileItem({@required this.file, Key key});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Text(file.id),
        title: Text(file.name),
        subtitle: Text(file.size),
      );
}

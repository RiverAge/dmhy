import 'package:dmhy/model/torrent/file.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class FilesState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilesInitial extends FilesState {}

class FilesPending extends FilesState {}

class FilesLoaded extends FilesState {
  final List<File> files;

  FilesLoaded({@required this.files});
}

class FilesFailed extends FilesState {
  final String error;
  FilesFailed({@required this.error}) : assert(error != null);
}

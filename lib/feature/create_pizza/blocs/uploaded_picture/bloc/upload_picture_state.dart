part of 'upload_picture_bloc.dart';

sealed class UploadPictureState extends Equatable {
  const UploadPictureState();

  @override
  List<Object> get props => [];
}

final class UploadPictureInitial extends UploadPictureState {}

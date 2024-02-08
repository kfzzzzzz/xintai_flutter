part of 'ai_photo_page_bloc.dart';

// class AiPhotoPageState extends Equatable {
//   const AiPhotoPageState();

//   @override
//   List<Object> get props => [];
// }

abstract class AiPhotoPageState {}

class AiPhotoPageInitial extends AiPhotoPageState {}

class AiPhotoPageContent extends AiPhotoPageState {
  final List<CivitaiImageItem> imageItems;
  final List<int> NSFW;
  final String sort;

  AiPhotoPageContent(this.imageItems, this.NSFW, this.sort) : super();
}

class AiPhotoPageLoadFail extends AiPhotoPageState {}

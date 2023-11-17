abstract class AnnouncementEvent {}

class FetchAnnouncementData extends AnnouncementEvent {}

abstract class AnnouncementState {}

class AnnouncementLoading extends AnnouncementState {}

class AnnouncementLoaded extends AnnouncementState {
  final dynamic announcementData;

  AnnouncementLoaded({required this.announcementData});
}

class AnnouncementLoadFailure extends AnnouncementState {}

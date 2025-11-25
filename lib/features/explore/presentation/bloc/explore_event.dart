part of 'explore_bloc.dart';

class ExploreEvent {}

class GetAllSubjectsEvent extends ExploreEvent {}

class GetSpecificSubjectsEvent extends ExploreEvent {
  final String query;
  GetSpecificSubjectsEvent({required this.query});
}

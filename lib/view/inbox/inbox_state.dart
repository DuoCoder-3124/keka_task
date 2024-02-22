part of 'inbox_view.dart';

abstract class InboxState extends Equatable {
  const InboxState();
}

class InboxInitial extends InboxState {
  @override
  List<Object> get props => [];
}

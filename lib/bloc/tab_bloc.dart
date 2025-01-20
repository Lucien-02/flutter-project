import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class TabEvent {}

class SelectTabEvent extends TabEvent {
  final int index;
  SelectTabEvent(this.index);
}

// State
class TabState {
  final int currentIndex;
  TabState({this.currentIndex = 0});
}

// Bloc
class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState()) {
    on<SelectTabEvent>((event, emit) {
      emit(TabState(currentIndex: event.index));  // Change tab index
    });
  }
}

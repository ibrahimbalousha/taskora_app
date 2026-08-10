sealed class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}

class MainLayoutTabChanged extends MainLayoutState {
  final int currentIndex;

  MainLayoutTabChanged(this.currentIndex);
}
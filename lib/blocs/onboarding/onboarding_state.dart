part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final User user;
  final GoogleMapController? mapController;
  final TabController tabController;

  const OnboardingLoaded({
    required this.user,
    this.mapController,
    required this.tabController,
  });

  @override
  List<Object?> get props => [
        user,
        mapController,
        tabController,
      ];
}

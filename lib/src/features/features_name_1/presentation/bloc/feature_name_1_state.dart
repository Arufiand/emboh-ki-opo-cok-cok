part of 'feature_name_1_bloc.dart';

abstract class FeatureName1State extends Equatable {
  const FeatureName1State();

  @override
  List<Object> get props => [];
}

class FeatureName1Initial extends FeatureName1State {}
class FeatureName1Loading extends FeatureName1State {}
class FeatureName1Loaded extends FeatureName1State {
  final String data; // Replace with your actual data type
  const FeatureName1Loaded(this.data);

  @override
  List<Object> get props => [data];
}
class FeatureName1Error extends FeatureName1State {
  final String message;
  const FeatureName1Error(this.message);

  @override
  List<Object> get props => [message];
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'feature_name_1_event.dart';
part 'feature_name_1_state.dart';

class FeatureName1Bloc extends Bloc<FeatureName1Event, FeatureName1State> {
  FeatureName1Bloc() : super(FeatureName1Initial()) {
    on<FeatureName1Event>((event, emit) {
      // TODO: Implement event handlers
    });
  }
}
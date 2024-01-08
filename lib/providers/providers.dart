import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seat_finder/utils/constants.dart';

final isSearchedProviders = List.generate(
  seatsInTrain,
  (_) => StateProvider<bool>((ref) => false),
);

final isMarkedProviders = List.generate(
  seatsInTrain,
  (_) => StateProvider<bool>((ref) => false),
);

final prevSearchSeatNumProvider = StateProvider<int?>((ref) => null);


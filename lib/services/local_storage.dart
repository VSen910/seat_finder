import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:seat_finder/providers/providers.dart';
import 'package:seat_finder/utils/constants.dart';

class LocalStorage {
  static Box? box;

  static void populateData(WidgetRef ref) {
    for (int i = 0; i < seatsInTrain; i++) {
      ref
          .read(isMarkedProviders[i].notifier)
          .update((state) => box!.get(i, defaultValue: false));
    }
  }

  static void updateStorage(int seatNum) {
    box!.put(seatNum - 1, !box!.get(seatNum - 1, defaultValue: false));
  }
}

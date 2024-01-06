import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:seat_finder/providers/providers.dart';
import 'package:seat_finder/utils/constants.dart';

Box? box;

class LocalStorage {
  static void initStorage() async {
    box!.put(
        'isMarkedStatus', List<bool>.generate(seatsInTrain, (index) => false));
  }

  static void populateData(WidgetRef ref) {
    // var list = box!.get(
    //   'isMarkedStatus',
    //   defaultValue: List.filled(seatsInTrain, false),
    // );
    for (int i = 0; i < seatsInTrain; i++) {
      ref
          .read(isMarkedProviders[i].notifier)
          .update((state) => box!.get(i, defaultValue: false));
      // print(list[i]);
    }
  }

  static void updateStorage(int seatNum) {
    // var list = box!.get(
    //   'isMarkedStatus',
    //   defaultValue: List.filled(seatsInTrain, false),
    // );
    // list[seatNum - 1] = !list[seatNum - 1];
    // print(box!.get('isMarkedStatus')[seatNum - 1]);
    box!.put(seatNum - 1, !box!.get(seatNum - 1, defaultValue: false));
  }
}

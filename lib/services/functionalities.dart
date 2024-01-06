import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seat_finder/services/local_storage.dart';

import '../providers/providers.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class Functionalities {
  static void searchSeat(
      BuildContext context,
      WidgetRef ref,
      TextEditingController searchController,
      ItemScrollController itemScrollController) {
    try {
      final prevSearchSeatNum = ref.read(prevSearchSeatNumProvider);
      final prevIsSearchedProvider =
          isSearchedProviders[(prevSearchSeatNum ?? 1) - 1];
      int seatNum = int.parse(searchController.text);
      final isSearchedProvider = isSearchedProviders[seatNum - 1];

      ref.read(prevIsSearchedProvider.notifier).update((state) => false);
      ref.read(isSearchedProvider.notifier).update((state) => true);
      ref.read(prevSearchSeatNumProvider.notifier).update((state) => seatNum);

      int index = 150;
      if(seatNum%4 == 3 && (seatNum+1)%8 == 0) {
        index = (((seatNum-3) / 4) - 1).toInt();
      } else if(seatNum%8 == 0) {
        index = (seatNum-4) ~/ 4;
      } else {
        index = seatNum ~/ 4;
      }

      itemScrollController.scrollTo(
          index: index,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubic);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(invalidInputText),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: AppColors.secondary,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  static void resetSeats(WidgetRef ref) {
    final prevSearchSeatNum = ref.read(prevSearchSeatNumProvider);
    if (prevSearchSeatNum != null) {
      final prevIsSearchedProvider = isSearchedProviders[prevSearchSeatNum - 1];
      ref.read(prevIsSearchedProvider.notifier).update((state) => false);
    }

    for (var provider in isMarkedProviders) {
      ref.read(provider.notifier).update((state) => false);
    }
    for (int i = 0; i < seatsInTrain; i++) {
      box!.put(i, false);
    }
  }
}

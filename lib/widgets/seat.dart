import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seat_finder/providers/providers.dart';
import 'package:seat_finder/services/local_storage.dart';
import 'package:seat_finder/utils/colors.dart';
import 'package:seat_finder/utils/styles.dart';

import '../utils/constants.dart';

class Seats {
  static List<Seat> seats = [];

  static initSeats() {
    String seatType = 'Lower';
    for (int i = 0; i < seatsInTrain; i++) {
      if (i % 8 == 0 || i % 8 == 3) {
        seatType = 'Lower';
      } else if (i % 8 == 1 || i % 8 == 4) {
        seatType = 'Middle';
      } else if (i % 8 == 2 || i % 8 == 5) {
        seatType = 'Upper';
      } else if (i % 8 == 6) {
        seatType = 'Side Lower';
      } else {
        seatType = 'Side Upper';
      }

      seats.add(
        Seat(
          seatNum: i + 1,
          seatType: seatType,
        ),
      );
    }
  }
}

class Seat extends ConsumerWidget {
  const Seat({super.key, required this.seatNum, required this.seatType});

  final int seatNum;
  final String seatType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearched = ref.watch(isSearchedProviders[seatNum - 1]);
    final isMarked = ref.watch(isMarkedProviders[seatNum - 1]);

    return GestureDetector(
      onTap: () {
        ref
            .read(isMarkedProviders[seatNum - 1].notifier)
            .update((state) => !state);
        LocalStorage.updateStorage(seatNum);
      },
      child: Container(
        height: 60.w,
        width: 60.w,
        decoration: BoxDecoration(
          color: isMarked ? AppColors.accent : AppColors.primary,
          border: isSearched ? Border.all(color: AppColors.accent) : null,
          borderRadius: AppStyles.borderRadiusSeat,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                '$seatNum',
                style: TextStyle(
                  color: isMarked ? Colors.white : Colors.black,
                ),
              ),
            ),
            Positioned(
              bottom: 5.w,
              child: Text(
                seatType,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: isMarked ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

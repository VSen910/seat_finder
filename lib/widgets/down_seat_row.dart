import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seat_finder/utils/colors.dart';
import 'package:seat_finder/utils/styles.dart';
import 'package:seat_finder/widgets/seat.dart';

class DownSeatRow extends StatelessWidget {
  const DownSeatRow({super.key, required this.initSeatNum});

  final int initSeatNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 40.h,
                width: 202.w,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppStyles.borderRadiusDownSeatBackground,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Seats.seats[initSeatNum - 1],
                  Container(
                    height: 60.w,
                    width: 1.w,
                    color: AppColors.background,
                  ),
                  Seats.seats[initSeatNum + 1 - 1],
                  Container(
                    height: 60.w,
                    width: 1.w,
                    color: AppColors.background,
                  ),
                  Seats.seats[initSeatNum + 2 - 1],
                ],
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 40.h,
                width: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppStyles.borderRadiusDownSeatBackground,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 8.0,
              ),
              child: Seats.seats[initSeatNum + 4 - 1],
            ),
          ],
        )
      ],
    );
  }
}

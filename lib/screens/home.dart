import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seat_finder/services/functionalities.dart';
import 'package:seat_finder/services/local_storage.dart';
import 'package:seat_finder/utils/colors.dart';
import 'package:seat_finder/utils/constants.dart';
import 'package:seat_finder/widgets/seat.dart';
import 'package:seat_finder/utils/styles.dart';
import 'package:seat_finder/widgets/down_seat.dart';
import 'package:seat_finder/widgets/up_seat.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final searchController = TextEditingController();
  final itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    Seats.initSeats();
    Future<void>(() {
      LocalStorage.populateData(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search a seat',
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: AppStyles.borderRadiusSearch,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: AppStyles.borderRadiusSearch,
                        borderSide: BorderSide(
                          color: AppColors.accent,
                        ),
                      ),
                      suffixIconColor: AppColors.accent,
                      suffixIcon: Consumer(
                        builder: (context, ref, child) {
                          return IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              Functionalities.searchSeat(
                                context,
                                ref,
                                searchController,
                                itemScrollController,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemScrollController: itemScrollController,
                    itemCount: rowsInTrain,
                    itemBuilder: (context, index) {
                      if (index % 2 == 0) {
                        return Column(
                          children: [
                            UpSeat(initSeatNum: 4 * index + 1),
                            SizedBox(height: 20.h),
                          ],
                        );
                      } else {
                        return DownSeat(initSeatNum: 4 * index);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, child) {
                            return ElevatedButton(
                              style: AppStyles.secondaryButtonStyle,
                              onPressed: () {
                                Functionalities.resetSeats(ref);
                              },
                              child: Text(
                                resetText,
                                style: TextStyle(color: AppColors.accent),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

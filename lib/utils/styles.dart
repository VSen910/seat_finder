import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyles {
  static const borderRadiusSeat = BorderRadius.all(
    Radius.circular(5),
  );

  static const borderRadiusSearch = BorderRadius.all(
    Radius.circular(10),
  );

  static const borderRadiusDownSeatBackground = BorderRadius.only(
    topLeft: Radius.circular(5),
    topRight: Radius.circular(5),
  );

  static const borderRadiusUpSeatBackground = BorderRadius.only(
    bottomLeft: Radius.circular(5),
    bottomRight: Radius.circular(5),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(color: AppColors.accent),
    ),
  );

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: AppColors.accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
# Find your seat

Download the app from here:  
https://drive.google.com/drive/u/0/folders/1mn0-CR8TRTsOltUblJrh-Ur-Nt3UMDsk

Find your seat is a mobile app that helps you find your seat in Indian Trains by pin-pointing the exact location of your seat inside the coach. Some of the key features of this app include:  
1. Search for your seat using a searchbar to highlight the location of your seat in the coach
2. Auto-scroll to the location of the seat on searching
3. Tap to mark and save the seats in local storage for future reference
4. Reset button to clear the searched and marked seats

## Built with
1. *Flutter*
2. *Riverpod (State Management)*
3. *Hive (local storage)*

## Getting Started

These guidelines will help you set up and run the project on your local machine, specifically for development and testing purposes.

### Prerequisites

Before you begin, make sure you have the following installed:

1. **Flutter SDK:** Install Flutter by following the [official installation guide](https://flutter.dev/docs/get-started/install).

2. **IDE:** Choose your preferred Integrated Development Environment (IDE):
   - [VSCode](https://code.visualstudio.com/) with the Flutter extension installed.
   - [Android Studio](https://developer.android.com/studio) with the Flutter plugin.

3. **Device/Emulator:** You can run your app on a physical device or use an emulator. Make sure it's set up and working.

### Installation

Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/VSen910/seat_finder.git
```

Navigate to the project directory:

```bash
cd seat_finder
```

Run the following command to install the dependencies:
```bash
flutter pub get
```

Connect your device or run an emulator, then run the app using: 
```bash
flutter run
```

## Methodology
The code has been written in a way keeping it as modular as possible to make it as reusable and follow the principles of DRY (Don't Repeat yourself). The file structure used is as follows:

```bash
├──...
├── lib                    
│   ├── providers        
│   ├── screens            
│   ├── services             
│   ├── utils
│   ├── widgets
│   └── main.dart  
└── ...
```

To implement the search, tap to mark as well as the reset button functionalities, the following two lists of providers were utilised:

```
final isSearchedProviders = List.generate(
  seatsInTrain,
  (_) => StateProvider<bool>((ref) => false),
);

final isMarkedProviders = List.generate(
  seatsInTrain,
  (_) => StateProvider<bool>((ref) => false),
);
```

Auto Scrolling on search has been implemented using the `itemScrollController` provided to `ScrollablePositionedList.builder()` from the package [scrollable_positioned_list](https://pub.dev/packages/scrollable_positioned_list). The widget is implemented as follows: 

```
ScrollablePositionedList.builder(
  itemScrollController: itemScrollController,
  itemCount: rowsInTrain,
  itemBuilder: (context, index) {
    if (index % 2 == 0) {
      return Column(
        children: [
          UpSeatRow(initSeatNum: 4 * index + 1),
          SizedBox(height: 20.h),
        ],
      );
    } else {
      return DownSeatRow(initSeatNum: 4 * index);
    }
  },
),
```

The `scrollTo` method of the `itemScrollController` utilises the index of the item in the `ScrollablePositionedList` to auto scroll to that item, which means, to auto scroll to the searched seat, the index of the row of the seat is required (since the item here is the `UpSeatRow`/`DownSeatRow`), which is calculated from the seat number as follows:

```
if(seatNum%4 == 3 && (seatNum+1)%8 == 0) {
  index = (((seatNum-3) / 4) - 1).toInt();
} else if(seatNum%8 == 0) {
  index = (seatNum-4) ~/ 4;
} else {
  index = seatNum ~/ 4;
}
```

Every time the app is started, it fetches the data that was saved on local storage or the Hive box, and updates the List of state providers of marked seats to update the UI as to as it was left previously using the following function:
```
static void populateData(WidgetRef ref) {
  for (int i = 0; i < seatsInTrain; i++) {
    ref
        .read(isMarkedProviders[i].notifier)
        .update((state) => box!.get(i, defaultValue: false));
  }
}
```

Finally, to implement a responsive UI, the flutter package [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) has been utilised.


## Screen recording

[new recording.webm](https://github.com/VSen910/seat_finder/assets/104011412/cbbbe85b-9d9c-4ee6-b840-cb83084898f2)

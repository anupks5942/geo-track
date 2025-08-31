import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:universe/universe.dart';

class MapTypeProvider with ChangeNotifier, WidgetsBindingObserver {
  GoogleMapType _selectedType = GoogleMapType.Street; // Default map type
  int _selectedTypeID = 0; // ID for the selected type

  GoogleMapType get selectedType => _selectedType;
  int get selectedTypeID => _selectedTypeID;
//////////////////////////////////////////////////////////////////////////////////
  MapTypeProvider() {
    WidgetsBinding.instance.addObserver(this); // Add observer
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (brightness == Brightness.dark) {
      _setMapTypeToHybrid();
    } else {
      _setMapTypeToNormal();
    }
  }

  void _setMapTypeToHybrid() {
    _selectedType = GoogleMapType.Hybrid;
    _selectedTypeID = 1;
    notifyListeners(); // Notify listeners about the change
  }

  void _setMapTypeToNormal() {
    _selectedType = GoogleMapType.Street;
    _selectedTypeID = 0;
    notifyListeners(); // Notify listeners about the change
  }

  void updateMapTypeBasedOnTheme(Brightness brightness) {
    if (brightness == Brightness.dark) {
      _selectedType = GoogleMapType.Hybrid;
      _selectedTypeID = 1;
    } else {
      _selectedType = GoogleMapType.Street;
      _selectedTypeID = 0;
    }
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////////////
  void setMapType(GoogleMapType mapType, int id) {
    _selectedType = mapType;
    _selectedTypeID = id;
    notifyListeners(); // Notify listeners about the change
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.zero,
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          height: 150.h,
          // height: height * 0.25,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateModal) {
              return Padding(
                // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 10.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Map type",
                          style: GoogleFonts.sora(
                            fontSize: 14.sp,
                            // fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildMapTypeOption(
                          GoogleMapType.Street,
                          'Default',
                          Icons.streetview,
                          0,
                          setStateModal,
                        ),
                        _buildMapTypeOption(
                          GoogleMapType.Hybrid,
                          'Satellite',
                          Icons.satellite_alt,
                          1,
                          setStateModal,
                        ),
                        _buildMapTypeOption(
                          GoogleMapType.Terrain,
                          'Terrain',
                          Icons.terrain,
                          2,
                          setStateModal,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildMapTypeOption(GoogleMapType mapType, String label, IconData icon,
      int id, StateSetter setStateModal) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: () {
        setMapType(mapType, id);
        setStateModal(() {
          _selectedTypeID = id;
        });
      },
      child: SizedBox(
        width: 100.w,
        height: 100.w,
        // width: width * 0.25,
        // height: width * 0.25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: _selectedTypeID == id
                    ? BoxDecoration(
                        border: Border.all(
                          width: 2.w,
                          color: const Color.fromARGB(255, 27, 109, 244),
                        ),
                        borderRadius: BorderRadius.circular(8.r))
                    : null,
                padding: EdgeInsets.all(4.w),
                // padding: EdgeInsets.all(width * 0.01),
                child: Icon(
                  icon,
                  size: 40.w,
                  // size: width * 0.1,
                  // size: width * 0.1,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.sora(
                  fontSize: 10.sp,
                  // fontSize: width * 0.03,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

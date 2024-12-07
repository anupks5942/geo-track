import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geo_track/pages/tabs/dashboard.dart';
import 'package:geo_track/services/providers/map_type_provider.dart';
import 'package:geo_track/utils/animated_navigation.dart';
import 'package:geo_track/utils/constants.dart';
import 'package:geo_track/pages/features/map/check_out_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart' hide Locator;
import 'package:geo_track/services/providers/geofence_provider.dart';
import 'package:universe/universe.dart';

class MapScreen extends StatefulWidget {
  // final bool fromNoti;
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _controller = TextEditingController();

  final _mapKey = UniqueKey();
  final _mapController = MapController();

  bool _isSearching = false;
  Future _findLocation() async {
    setState(() {
      _isSearching = true;
    });
    await _mapController.locate(automove: true, toZoom: 17);
    setState(() {
      _isSearching = false;
    });
  }

  void _moveToOffice(loction) {
    _mapController.move(loction, zoom: 16, animate: true);
  }

  @override
  void initState() {
    // _setDarkStatusBarIcons();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (Theme.of(context).brightness == Brightness.dark) {
        context.read<MapTypeProvider>().setMapType(GoogleMapType.Hybrid, 1);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.read<GeofenceProvider>().startGeofenceTracking();

    if (fromNoti && !dialogShown) {
      setState(() {
        dialogShown = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCheckOutDialog(context);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final geofenceWatch = context.watch<GeofenceProvider>();
    final geofenceRead = context.read<GeofenceProvider>();

    final mapTypeRead = context.read<MapTypeProvider>();
    final mapTypeWatch = context.watch<MapTypeProvider>();

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _findLocation(),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            tooltip: 'Locate yourself',
            shape: const CircleBorder(),
            child: _isSearching
                ? Icon(
                    Icons.location_searching,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.grey[900],
                    // : const Color(0xFF121B22),
                  )
                : Icon(
                    Icons.my_location,
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color.fromARGB(255, 27, 109, 244)
                        : const Color.fromARGB(255, 168, 200, 249),
                  ),
          ),
          SizedBox(
            height: 5.h,
            // height: height * 0.01,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () => _moveToOffice(geofenceRead.officeLocation),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            tooltip: 'Locate Office',
            shape: const CircleBorder(),
            child: Icon(
              Icons.location_on,
              color: Theme.of(context).brightness == Brightness.light
                  ? const Color.fromARGB(255, 27, 109, 244)
                  : const Color.fromARGB(255, 168, 200, 249),
            ),
          ),
          SizedBox(
            // height: height * 0.01,
            height: 5.h,
          ),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: const Color.fromARGB(255, 27, 109, 244),
            onPressed: () {
              Navigator.of(context).push(
                AnimatedNavigation()
                    .rightToLeftTransition(const AnalyticsScreen()),
              );
            },
            tooltip: 'Dashboard',
            child: const Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                // color: Color.fromARGB(255, 27, 109, 244),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          U.GoogleMap(
            center: geofenceRead.officeLocation,
            type: mapTypeWatch.selectedType,
            key: _mapKey,
            controller: _mapController,
            zoom: 16,
            minZoom: 13,
            maxZoom: 18,
            live: true,
            moveWhenLive:
                false, // always takes you to your current position in the map
            showLocator:
                false, // if false, no blue mark of location & no FAB to locate
            showLocationIndicator: true, // if true, shows blue mark of location
            showScale: false,
            options: TileLayerOptions(
              tileProvider: const CachedNetworkTileProvider(),
            ),
            // locator: const Locator(
            //   icon: Icon(
            //     Icons.my_location,
            //   ),
            // ),
            compass: Compass(
              margin: EdgeInsets.only(top: 70.h, right: 8.w),
              icon: Tooltip(
                message: 'Direction',
                child: Icon(
                  Icons.north,
                  size: 20.sp,
                  color: Colors.black,
                ),
              ),
            ),
            locationIndicator: const LocationIndicator(
              radius: 8,
              // overlayRadius: 150, // radius of circle around current location
              ringRadius: 2,
              color: Color.fromARGB(255, 27, 109, 244),
            ),
            onReady: () {
              _findLocation();
            },
            controls: [
              Positioned(
                top: 30.h,
                left: 8.w,
                right: 8.w,
                child: SizedBox(
                  height: 35.h,
                  child: SearchBar(
                    controller: _controller,
                    hintText: "Latitude, Longitude, Radius",
                    leading: const Icon(Icons.location_on),
                    keyboardType: const TextInputType.numberWithOptions(),
                    onSubmitted: (value) {
                      log("value $value");
                      _moveToOffice(geofenceRead.officeLocation);
                      geofenceWatch.setGeofenceCenter(value, context);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 70.h,
                left: 8.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[500]!
                            : Colors.black, // 500,black
                        offset: const Offset(3, 3), // 5,5
                        blurRadius: 10,
                        spreadRadius: 1, // 5
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 8.w,
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'Office: ',
                              children: [
                                TextSpan(
                                  text: 'GAIL Office, Bhopal',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Status: ',
                              children: [
                                geofenceWatch.isInsideGeofence
                                    ? TextSpan(
                                        text: "Checked In",
                                        style: GoogleFonts.poppins(
                                            color: Colors.green,
                                            fontWeight: FontWeight.normal))
                                    : TextSpan(
                                        text: "Checked Out",
                                        style: GoogleFonts.poppins(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.normal)),
                              ],
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                        // height: height * 0.01,
                      ),
                      Tooltip(
                        message: "Quick Check-out",
                        child: TextButton(
                          onPressed: () => showCheckOutDialog(context),
                          child: const Text(
                            'Check Out',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 103.h,
                right: 8.w,
                child: Tooltip(
                  message: "Change Map type",
                  child: GestureDetector(
                    onTap: () => mapTypeRead.showBottomSheet(context),
                    child: Container(
                      height: 40,
                      width: 40,
                      // padding: EdgeInsets.all(3.w),
                      // clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            )
                          ]),
                      child: Icon(
                        Icons.layers,
                        size: 20.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            markers: U.MarkerLayer(
              [
                U.Marker(
                  geofenceWatch.officeLocation,
                  data: 'GAIL Office, MP',
                  widget: const Icon(
                    Icons.location_pin,
                    color: Color.fromARGB(100, 255, 0, 0),
                    size: 40,
                  ),
                ),
              ],
              onTap: (latlng, data) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$data'),
                ));
              },
            ),
            circles: U.CircleLayer(
              geofenceWatch.officeLocation,
              radius: geofenceWatch.geofenceRadius,
              strokeColor: Colors.blue,
              fillOpacity: 0.3,
              strokeWidth: 2,
              data: 'Geofenced Area : 200m',
              onTap: (position, data) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$data')),
                );
              },
            ),
            onTap: print,
            onLongPress: (p0) {
              log(p0.toString());
              geofenceRead.getGeofenceCenter(
                  p0.toString(), _controller, context);
            },
          ),
          // if (_isSearching)
          //   const Center(
          //     child: CircularProgressIndicator(
          //         strokeWidth: 2,
          //         valueColor: AlwaysStoppedAnimation<Color>(
          //             Color.fromARGB(255, 27, 109, 244))),
          //   ),
        ],
      ),
    );
  }
}

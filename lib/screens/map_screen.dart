import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_location.dart';

const defaultLatitude = 37.42796133580664;
const defaultLongitude = -122.085749655962;

class MapScreen extends StatefulWidget {
  static const routeName = '/map';

  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.initialLocation = const PlaceLocation(
      latitude: defaultLatitude,
      longitude: defaultLongitude,
    ),
    this.isSelecting = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
                onPressed: () => _pickedLocation == null
                    ? null
                    : Navigator.of(context).pop(_pickedLocation),
                icon: const Icon(Icons.check)),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : <Marker>{
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                ),
              },
      ),
    );
  }
}

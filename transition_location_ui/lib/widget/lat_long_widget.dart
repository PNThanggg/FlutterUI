import 'package:flutter/material.dart';

import '../model/location.dart';

class LatLongWidget extends StatelessWidget {
  final Location location;

  const LatLongWidget({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            location.latitude,
            style: const TextStyle(color: Colors.white70),
          ),
          const Icon(Icons.location_on, color: Colors.white70),
          Text(
            location.longitude,
            style: const TextStyle(color: Colors.white70),
          )
        ],
      );
}

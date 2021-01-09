import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'dart:math';

class Position {
  static final List<double> tolimasKampas = [55.551132, 25.057135];
  static final List<double> ivaziavimas = [55.55027, 25.064513];
  static final double latitudeMultiplyer = 111200.00;
  static final double longitudeMultiplyer = 63788.00;

  static List<double> getPositionMeters(LocationData locationData) {
    final farLatShift_X =
        (locationData.latitude - tolimasKampas[0]) * latitudeMultiplyer;
    final farLongShift_Y =
        (locationData.longitude - tolimasKampas[1]) * longitudeMultiplyer;
    final nearLatShift_X =
        (locationData.latitude - ivaziavimas[0]) * latitudeMultiplyer;
    final nearLongShift_Y =
        (locationData.longitude - ivaziavimas[1]) * longitudeMultiplyer;
    // print("farLatShift_X - tolimas " +
    //     (locationData.latitude - tolimasKampas[0]).toString());
    // print("farLatShift_X: " + farLatShift_X.toString());
    // print("nearLatShift_X" + nearLatShift_X.toString());

    final dirty_Y =
        0.5173625 * farLatShift_X - 0.855778 * farLongShift_Y + 447.6036;
    final distFromEntrance =
        pow((pow(nearLatShift_X, 2) + pow(nearLongShift_Y, 2)), .5);
    final dirty_X = pow((pow(distFromEntrance, 2) - pow(dirty_Y, 2)), .5);
    final correction_X = dirty_Y * 0.3583;
    final shift_X_meters = dirty_X + correction_X;
    final shift_Y_meters = dirty_Y + shift_X_meters * 0.05;
    return [shift_X_meters, shift_Y_meters];
  }

  static List<double> getRelativePosition(
      LocationData locationData, List<double> marginsWidhts) {
    //margins values should be x-left, x-right, width, y-bottom, y-top, height
    List<double> meters = getPositionMeters(locationData);
    final double fraction_x = meters[0] /
            911.8 *
            (marginsWidhts[2] -
                marginsWidhts[2] * marginsWidhts[0] -
                marginsWidhts[2] * marginsWidhts[1]) +
        marginsWidhts[2] * marginsWidhts[0];
    final double fraction_y = meters[1] /
            911.8 *
            (marginsWidhts[5] -
                marginsWidhts[5] * marginsWidhts[3] -
                marginsWidhts[5] * marginsWidhts[4]) +
        marginsWidhts[5] * marginsWidhts[3];

    return [fraction_x, fraction_y];
  }

  static List<double> getRelativePositionForAlign(LocationData locationData) {
    //margins values should be x-left, x-right, width, y-bottom, y-top, height
    // print(locationData.latitude.toString() +
    //     ',' +
    //     locationData.longitude.toString());
    List<double> meters = getPositionMeters(locationData);
    // print("Meters " + meters.toString());
    final double fraction_x = (meters[0] / 911.8 * 2) - 1;
    final double fraction_y = (meters[1] / 911.8) - 1;
    return [fraction_x, fraction_y];
  }
}

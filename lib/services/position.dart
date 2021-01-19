import 'dart:math';

import 'package:geolocation/geolocation.dart';

class Position {
  static final List<double> tolimasKampas = [55.551132, 25.057135];
  static final List<double> ivaziavimas = [55.55027, 25.064513];
  static final double latitudeMultiplyer = 111200.00;
  static final double longitudeMultiplyer = 63788.00;

  static List<double> getPositionMetersTwo(List<double> location) {
    final farLatShift_X = (location[0] - tolimasKampas[0]) * latitudeMultiplyer;
    final farLongShift_Y =
        (location[1] - tolimasKampas[1]) * longitudeMultiplyer;
    final nearLatShift_X = (location[0] - ivaziavimas[0]) * latitudeMultiplyer;
    final nearLongShift_Y =
        (location[1] - ivaziavimas[1]) * longitudeMultiplyer;
    // print("farLatShift_X " + farLatShift_X.toString());
    // print("farLongShift_Y " + farLongShift_Y.toString());
    // print("nearLatShift_X: " + nearLatShift_X.toString());
    // print("nearLongShift_Y" + nearLongShift_Y.toString());

    final dirty_Y = (farLongShift_Y * tan(0.543766) + farLatShift_X + 865.164) *
            sin(0.543766) -
        farLongShift_Y / cos(0.543766);
    final dirty_X = (farLongShift_Y * tan(0.543766) + farLatShift_X + 865.164) *
            cos(0.543766) -
        896.045;
    return [dirty_X, dirty_Y];
  }

  static List<double> getRelativePositionForInclinedTwo(
      List<double> data, double width, double height, double iconHeight) {
    List<double> meters = getPositionMetersTwo(data);
    // print("longitude: " +
    //     data.longitude.toString() +
    //     "latitude: " +
    //     data.latitude.toString());
    // List<double> meters = [180.66, 300.304];
    var imageWidth;
    var imageHeight;
    var noPixelsLeftShift = 0.0;
    var noPixelsBottomShift = 0.0;
    if (width / height >= 1.8461) {
      imageWidth = height * 1.8461;
      imageHeight = height;
      noPixelsLeftShift = (width - imageWidth) / 2 - 10;
    } else {
      imageHeight = width * 1.8461;
      imageWidth = width;
      noPixelsBottomShift = (height - imageHeight) / 2;
    }
    // print("Meters " + meters.toString());
    // print("width, height " + width.toString() + ", " + height.toString());
    // print("imageWidth, imageHeight " +
    //     imageWidth.toString() +
    //     ", " +
    //     imageHeight.toString());

    final tanBeta1 = 573.32 / (meters[1] + 250);
    // print("tanBeta1 " + tanBeta1.toString());
    final beta1rad = atan(tanBeta1);
    // print("beta1rad " + beta1rad.toString());
    final beta2rad = 0.7830165744 - beta1rad;
    // print("beta2rad " + beta2rad.toString());

    final projectionY = meters[1] * sin(beta1rad) / cos(beta2rad);
    // print("projectionY " + projectionY.toString());

    final XdistanceFrom500 = 500 - meters[0];
    final shortcutX = 625.65 + (295 / 447.6) * meters[1];
    final projectionFrom400X = 626.65 / shortcutX * XdistanceFrom500;
    final projectionX = 500 - projectionFrom400X;
    // print("projectionX, projectionY " +
    //     projectionX.toString() +
    //     ", " +
    //     projectionY.toString());
    final newAngleRad = atan(projectionY / projectionX) + 0.109011345;
    final diagonal = pow((pow(projectionX, 2) + pow(projectionY, 2)), .5);
    // print("new angele degr, diagonal  " +
    //     newAngleRad.toString() +
    //     ", " +
    //     diagonal.toString());

    final rotationProjectionX = diagonal * cos(newAngleRad);
    final rotationProjectionY = diagonal * sin(newAngleRad);
    // print("rotationProjectionY " + rotationProjectionY.toString());
    // print("rotationProjectionX " + rotationProjectionX.toString());

    final relativeShiftX = (rotationProjectionX + 8.216) / 983.507;
    final relativeShiftY = (rotationProjectionY + 90.34) / 523.733;

    final positionX = relativeShiftX * imageWidth + noPixelsLeftShift;
    // print("empty shift left: $noPixelsLeftShift");
    final positionY = relativeShiftY * imageHeight + noPixelsBottomShift;
    // print("empty shift bottom: $noPixelsBottomShift, icon: $iconHeight");
    // 0.61 * rotationProjectionY / 446.1 * imageHeight +
    // iconHeight / 2 +
    // bottomOffset;
    // print("positionX, positionY " +
    //     positionX.toString() +
    //     ", " +
    //     positionY.toString());

    return [positionX, positionY];
  }
}

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

    final shift_Y_meters = dirty_Y;
    return [dirty_X, dirty_Y];
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
            446.1 *
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
    final double fraction_y = 1 - (meters[1] / 446.1 * 2);
    return [fraction_x, fraction_y];
  }

  static List<double> getRelativePositionForPositioned(
      LocationData data, double width, double height, double iconHeight) {
    List<double> meters = getPositionMeters(data);
    final imageWidth = height * 2.113;
    final leftOffsetPx = (width - imageWidth) / 2 + .0131 * imageWidth;
    final rightOffsetPx = (width - imageWidth) / 2 + .0131 * imageWidth;
    final bottomOffsetPx = .01617 * height;
    final topOffsetPx = .057737 * height;

    // print("Meters " + meters.toString());

    final positionPxX =
        meters[0] / 911.8 * (width - leftOffsetPx - rightOffsetPx) +
            rightOffsetPx;
    final positionPxY =
        meters[1] / 446.1 * (height - bottomOffsetPx - topOffsetPx) +
            bottomOffsetPx +
            iconHeight / 2;
    return [positionPxX, positionPxY];
  }

  static List<double> getRelativePositionForAligned(LocationData locationData) {
    //margins values should be x-left, x-right, width, y-bottom, y-top, height
    // print(locationData.latitude.toString() +
    //     ',' +
    //     locationData.longitude.toString());
    List<double> meters = getPositionMeters(locationData);
    // print("Meters " + meters.toString());
    final double fraction_x = (meters[0] / 911.8 * 2) - 1;
    final double fraction_y = 1 - (meters[1] / 446.1 * 2);
    return [fraction_x, fraction_y];
  }

  static List<double> getRelativePositionForInclined(
      LocationData data, double width, double height, double iconHeight) {
//    List<double> meters = getPositionMeters(data);
    List<double> meters = [817.036514111347, 388.796994666771];
    final imageWidth = height * 1.8461;
    print("Meters " + meters.toString());
    print("width, height " + width.toString() + ", " + height.toString());

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
    print("projectionX, projectionY " +
        projectionX.toString() +
        ", " +
        projectionY.toString());
    final newAngleRad = atan(projectionY / projectionX) + 0.109011345;
    final diagonal = pow((pow(projectionX, 2) + pow(projectionY, 2)), .5);
    print("new angele degr, diagonal  " +
        newAngleRad.toString() +
        ", " +
        diagonal.toString());

    final rotationProjectionX = diagonal * cos(newAngleRad);
    final rotationProjectionY = diagonal * sin(newAngleRad);
    print("rotationProjectionY " + rotationProjectionY.toString());
    print("rotationProjectionX " + rotationProjectionX.toString());

    final leftOffset = imageWidth * 0.003645833333;
    final bottomOffset = height * 0.1644230769;

    final positionX = 0.925 * rotationProjectionX / 911.8 * imageWidth + leftOffset;
    final positionY = 0.61 * rotationProjectionY / 446.1 * height +
        iconHeight / 2 +
        bottomOffset;
    print("positionX, positionY " +
        positionX.toString() +
        ", " +
        positionY.toString());

    return [positionX, positionY];
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/utility/index.dart';

class SliderModel {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  SliderModel(
      {@required this.sliderImageUrl,
      @required this.sliderHeading,
      @required this.sliderSubHeading});
}

final sliderArrayList = [
  SliderModel(
      sliderImageUrl: Assets.IMAGE_01,
      sliderHeading: TextConstants.SLIDER_HEADING_1,
      sliderSubHeading: TextConstants.SLIDER_DESC_1),
  SliderModel(
      sliderImageUrl: Assets.IMAGE_01,
      sliderHeading: TextConstants.SLIDER_HEADING_1,
      sliderSubHeading: TextConstants.SLIDER_HEADING_1),
];

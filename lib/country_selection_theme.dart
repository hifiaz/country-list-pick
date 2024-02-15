import 'package:flutter/material.dart';

class CountryTheme {
  final String? searchText;
  final String? searchHintText;
  final String? lastPickText;
  final bool? isShowAlphabet;
  final Color? alphabetSelectedBackgroundColor;
  final Color? alphabetTextColor;
  final Color? alphabetSelectedTextColor;
  final bool? isShowTitle;
  final bool? isShowFlag;
  final bool? isShowCode;
  final bool? isDownIcon;
  final String? initialSelection;
  final bool? showEnglishName;
  final Color? labelColor;
  final InputDecoration? searchInputDecoration;
  final Color? scaffoldColor;
  final Color? intialSelectionBackgroundColor;
  final TextStyle? intialSelectionTextStyle;
  final Color? searchInputBackground;
  final TextStyle? searchInputStyle;
  final Color? listBackgroundColor;
  final TextStyle? listTextStyle;

  CountryTheme(
      {this.labelColor,
      this.searchText,
      this.searchHintText,
      this.isShowAlphabet,
      this.lastPickText,
      this.alphabetSelectedBackgroundColor,
      this.alphabetTextColor,
      this.alphabetSelectedTextColor,
      this.isShowTitle,
      this.isShowFlag,
      this.isShowCode,
      this.isDownIcon,
      this.initialSelection,
      this.showEnglishName,
      this.searchInputDecoration,
      this.scaffoldColor,
      this.intialSelectionBackgroundColor,
      this.intialSelectionTextStyle,
      this.searchInputBackground,
      this.searchInputStyle,
      this.listBackgroundColor,
      this.listTextStyle});
}

import 'package:flutter/material.dart';

class CountryTheme {
  final String searchText;
  final String searchHintText;
  final String lastPickText;
  final Color alphabetSelectedBackgroundColor;
  final Color alphabetTextColor;
  final Color alphabetSelectedTextColor;
  final bool isShowTitle;
  final bool isShowFlag;
  final bool isShowCode;
  final bool isDownIcon;
  final String initialSelection;
  final bool showEnglishName;

  CountryTheme({
    this.searchText,
    this.searchHintText,
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
  });
}

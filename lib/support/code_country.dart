mixin ToAlias {}

@deprecated
class CElement = CountryCode with ToAlias;

/// Country element. This is the element that contains all the information
class CountryCode {
  /// the name of the country
  String? name;

  /// the flag of the country
  String? flagUri;

  /// the country code (IT,AF..)
  String? code;

  /// the dial code (+39,+93..)
  String? dialCode;

  CountryCode({this.name, this.flagUri, this.code, this.dialCode});

  @override
  String toString() => "$dialCode";

  String toLongString() => "$dialCode $name";

  String toCountryStringOnly() => '$name';

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "flagUri": this.flagUri,
      "code": this.code,
      "dialCode": this.dialCode,
    };
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) => CountryCode(
        name: json['name'],
        flagUri: json['flagUri'],
        code: json['code'],
        dialCode: json['dialCode'],
      );
}

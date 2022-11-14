extension IntExtensions on int {
  String get serialize => toString().length == 2
      ? '#0$this'
      : toString().length == 1
          ? '#00$this'
          : '$this';
}

class ResponsivePadding {
  static double get(double width) {
    if (width > 1400) {
      return 160;
    }
    if (width > 1000) {
      return 140;
    }
    if (width > 800) {
      return 80;
    }
    if (width > 500) {
      return 40;
    }
    return 4;
  }
}

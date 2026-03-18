enum AlcoholConsumption {
  casual('casual'),
  regular('regular'),
  seasoned('seasoned'),
  never('never');

  final String value;
  const AlcoholConsumption(this.value);

  static AlcoholConsumption fromString(String val) {
    return AlcoholConsumption.values.firstWhere(
      (e) => e.value == val,
      orElse: () => AlcoholConsumption.never,
    );
  }
}

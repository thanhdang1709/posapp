Map<String, String> loadLanguages(Map labelsGrouped) {
  Map<String, String> result = {};

  labelsGrouped.forEach((module, labels) {
    labels.forEach((keyLabel, valueLabel) {
      String key = module + '.' + keyLabel;
      result.addAll({key: valueLabel});
    });
  });

  return result;
}

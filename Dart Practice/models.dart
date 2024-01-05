class DogModel {
  final String model;
  final String breed;
  final String accuracy;

  DogModel({required this.model, required this.breed, required this.accuracy});

  factory DogModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'Model': String model,
        'Breed': String breed,
        'Accuracy': String accuracy,
      } =>
        DogModel(
          model: model,
          breed: breed,
          accuracy: accuracy,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

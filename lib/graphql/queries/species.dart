Future<List<Map<String, String>>> getSpecies() {
  return Future.delayed(const Duration(seconds: 1), () => [
    {'id': '1', 'name': 'Specie 01'},
    {'id': '2', 'name': 'Specie 02'},
    {'id': '3', 'name': 'Specie 03'},
    {'id': '4', 'name': 'Other'},
  ]);
}

Future<List<Map<String, String>>> getBreeds() {
  return Future.delayed(const Duration(seconds: 1), () => [
    {'id': '1', 'name': 'Breed 01'},
    {'id': '2', 'name': 'Breed 02'},
    {'id': '3', 'name': 'Breed 03'},
    {'id': '4', 'name': 'Other'},
  ]);
}

Future<List<Map<String, String>>> getColours() {
  return Future.delayed(const Duration(seconds: 3), () => [
    {'id': '1', 'name': 'Colour 01'},
    {'id': '2', 'name': 'Colour 02'},
    {'id': '3', 'name': 'Colour 03'},
    {'id': '4', 'name': 'Other'},
  ]);
}

Future<List<Map<String, String>>> getGenders() {
  return Future.delayed(const Duration(seconds: 2), () => [
    {'id': '1', 'name': 'Male'},
    {'id': '2', 'name': 'Female'},
  ]);
}
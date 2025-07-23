
class FontEntity {
  final int id;
  final String title;
  final String fontFamily;
  final String path;
  final String? language;

  const FontEntity({
    required this.id,
    required this.title,
    required this.fontFamily,
    required this.path,
    this.language,
  });
}

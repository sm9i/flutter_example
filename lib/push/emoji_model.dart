class EmojiModel {
  const EmojiModel({
    required this.name,
    required this.fileName,
    String? text,
  }) : _text = text ?? fileName;

  static const String dir = 'assets/emoji';

  final String name;
  final String fileName;
  final String _text;

  String get text => _text;

  String get path => '$dir/$fileName.png';
}

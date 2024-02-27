class AndroidIconTemplate {
  final String directory;
  final int size;

  const AndroidIconTemplate({
    required this.directory,
    required this.size,
  });

  static List<AndroidIconTemplate> get androidIconTemplateList => _androidIconTemplateList;

  static final List<AndroidIconTemplate> _androidIconTemplateList = List.unmodifiable([
    AndroidIconTemplate(size: 48, directory: 'mipmap-mdpi'),
    AndroidIconTemplate(size: 72, directory: 'mipmap-hdpi'),
    AndroidIconTemplate(size: 96, directory: 'mipmap-xhdpi'),
    AndroidIconTemplate(size: 144, directory: 'mipmap-xxhdpi'),
    AndroidIconTemplate(size: 192, directory: 'mipmap-xxxhdpi'),
  ]);
}

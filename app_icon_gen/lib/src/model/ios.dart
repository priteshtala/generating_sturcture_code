class IosIconTemplate {
  const IosIconTemplate({required this.size, required this.name});

  final String name;

  final int size;
  static List<IosIconTemplate> get iosIconTemplateList => _iosIconTemplateList;


  static final List<IosIconTemplate> _iosIconTemplateList = <IosIconTemplate>[
    const IosIconTemplate(name: '16', size: 16),
    const IosIconTemplate(name: '20', size: 20),
    const IosIconTemplate(name: '29', size: 29),
    const IosIconTemplate(name: '32', size: 32),
    const IosIconTemplate(name: '40', size: 40),
    const IosIconTemplate(name: '48', size: 48),
    const IosIconTemplate(name: '50', size: 50),
    const IosIconTemplate(name: '55', size: 55),
    const IosIconTemplate(name: '57', size: 57),
    const IosIconTemplate(name: '58', size: 58),
    const IosIconTemplate(name: '60', size: 60),
    const IosIconTemplate(name: '64', size: 64),
    const IosIconTemplate(name: '66', size: 66),
    const IosIconTemplate(name: '72', size: 72),
    const IosIconTemplate(name: '76', size: 76),
    const IosIconTemplate(name: '80', size: 80),
    const IosIconTemplate(name: '87', size: 87),
    const IosIconTemplate(name: '88', size: 88),
    const IosIconTemplate(name: '92', size: 92),
    const IosIconTemplate(name: '100', size: 100),
    const IosIconTemplate(name: '102', size: 102),
    const IosIconTemplate(name: '120', size: 120),
    const IosIconTemplate(name: '128', size: 128),
    const IosIconTemplate(name: '152', size: 152),
    const IosIconTemplate(name: '167', size: 167),
    const IosIconTemplate(name: '172', size: 172),
    const IosIconTemplate(name: '180', size: 180),
    const IosIconTemplate(name: '196', size: 196),
    const IosIconTemplate(name: '216', size: 216),
    const IosIconTemplate(name: '512', size: 512),
    const IosIconTemplate(name: '1024', size: 1024),
  ];
}

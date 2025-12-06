

class ElementResponseModel {
  final String? name;
  final String? appearance;
  final double? atomicMass;
  final double? boil;
  final String? category;
  final String? color;
  final double? density;
  final String? discoveredBy;
  final double? melt;
  final double? molarHeat;
  final String? namedBy;
  final int number;
  final int? period;
  final String? phase;
  final String? source;
  final String? spectralImg;
  final String? summary;
  final String? symbol;
  final int? xpos;
  final int? ypos;
  final String? electronConfiguration;
  final String? electronConfigurationSemantic;
  final double? electronAffinity;
  final double? electronegativityPauling;
  bool isFavourite;

  ElementResponseModel({
    this.name,
    this.appearance,
    this.atomicMass,
    this.boil,
    this.category,
    this.color,
    this.density,
    this.discoveredBy,
    this.melt,
    this.molarHeat,
    this.namedBy,
    required this.number,
    this.period,
    this.phase,
    this.source,
    this.spectralImg,
    this.summary,
    this.symbol,
    this.xpos,
    this.ypos,
    this.electronConfiguration,
    this.electronConfigurationSemantic,
    this.electronAffinity,
    this.electronegativityPauling,
    this.isFavourite = false,
  });

  /// Convert JSON → Model
  factory ElementResponseModel.fromJson(Map<String, dynamic> json) {
    return ElementResponseModel(
      name: json['name'],
      appearance: json['appearance'],
      atomicMass: (json['atomic_mass'] as num?)?.toDouble(),
      boil: (json['boil'] as num?)?.toDouble(),
      category: json['category'],
      color: json['color'],
      density: (json['density'] as num?)?.toDouble(),
      discoveredBy: json['discovered_by'],
      melt: (json['melt'] as num?)?.toDouble(),
      molarHeat: (json['molar_heat'] as num?)?.toDouble(),
      namedBy: json['named_by'],
      number: json['number'],
      period: json['period'],
      phase: json['phase'],
      source: json['source'],
      spectralImg: json['spectral_img'],
      summary: json['summary'],
      symbol: json['symbol'],
      xpos: json['xpos'],
      ypos: json['ypos'],
      electronConfiguration: json['electron_configuration'],
      electronConfigurationSemantic: json['electron_configuration_semantic'],
      electronAffinity: (json['electron_affinity'] as num?)?.toDouble(),
      electronegativityPauling:
      (json['electronegativity_pauling'] as num?)?.toDouble(),
    );
  }

  /// Convert Model → JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "appearance": appearance,
      "atomic_mass": atomicMass,
      "boil": boil,
      "category": category,
      "color": color,
      "density": density,
      "discovered_by": discoveredBy,
      "melt": melt,
      "molar_heat": molarHeat,
      "named_by": namedBy,
      "number": number,
      "period": period,
      "phase": phase,
      "source": source,
      "spectral_img": spectralImg,
      "summary": summary,
      "symbol": symbol,
      "xpos": xpos,
      "ypos": ypos,
      "electron_configuration": electronConfiguration,
      "electron_configuration_semantic": electronConfigurationSemantic,
      "electron_affinity": electronAffinity,
      "electronegativity_pauling": electronegativityPauling,
    };
  }
}
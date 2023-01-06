class FundingRequest {
  FundingRequest(
    this.ptech,
    this.length,
    this.width,
    this.actionArea,
    this.territory,
    this.inputNeedImplementationPtechs,
    this.jwtNFC,
  );

  factory FundingRequest.fromJson(Map<String, dynamic> json) {
    return FundingRequest(
      json['ptech'],
      json['length'],
      json['width'],
      json['actionArea'],
      json['territory'],
      json['inputNeedImplementationPtechs'],
      json['jwtNFC'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ptech': ptech,
      'length': length,
      'width': width,
      'actionArea': actionArea,
      'territory': territory,
      'inputNeedImplementationPtechs': inputNeedImplementationPtechs,
      'jwtNFC': jwtNFC,
    };
  }

  final String ptech;
  final String length;
  final String width;
  final List actionArea;
  final String territory;
  final List inputNeedImplementationPtechs;
  final String jwtNFC;
}

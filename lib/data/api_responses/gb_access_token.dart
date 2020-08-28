class GbAccessToken {
  String status;
  String creationTime;
  String regToken;
  dynamic expiration;
  dynamic customerId;

  GbAccessToken(
      {this.status,
      this.creationTime,
      this.regToken,
      this.expiration,
      this.customerId});

  GbAccessToken.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    creationTime = json['creationTime'];
    regToken = json['regToken'];
    expiration = json['expiration'];
    customerId = json['customerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['creationTime'] = this.creationTime;
    data['regToken'] = this.regToken;
    data['expiration'] = this.expiration;
    data['customerId'] = this.customerId;
    return data;
  }
}

class CustomerName {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  int? roleId;
  String? roleName;
  int? companyId;
  String? companyName;
  String? createdOn;
  bool? status;

  CustomerName(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.roleId,
      this.roleName,
      this.companyId,
      this.companyName,
      this.createdOn,
      this.status});

  CustomerName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    roleId = json['roleId'];
    roleName = json['roleName'];
    companyId = json['companyId'];
    companyName = json['companyName'];
    createdOn = json['createdOn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['roleId'] = roleId;
    data['roleName'] = roleName;
    data['companyId'] = companyId;
    data['companyName'] = companyName;
    data['createdOn'] = createdOn;
    data['status'] = status;
    return data;
  }
}
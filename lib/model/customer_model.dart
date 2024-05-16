class CustomerName {
  int? id;
  String? firstName;
  String? contactPerson;
  String? address;
  String? pinCode;
  String? country;
  String? state;
  String? city;
  String? area;
  String? email;
  String? contactNo;
  String? latitude;
  String? longitude;
  String? createdOn;
  int? createdBy;
  String? updatedOn;


  CustomerName(
      {this.id,
      this.firstName,
      this.contactPerson,
      this.address,
      this.pinCode,
      this.country,
      this.state,
      this.city,
      this.area,
      this.email,
      this.contactNo,
      this.latitude,
      this.longitude,
      this.createdOn,
      this.createdBy,
      this.updatedOn,
      });

  CustomerName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['name'];
    contactPerson = json['contactPerson'];
    address = json['address'];
    pinCode = json['pinCode'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    area = json['area'];
    email = json['email'];
    contactNo = json['contactNo'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdOn = json['createdOn'];
    createdBy = json['createdBy'];
    updatedOn = json['updatedOn'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = firstName;
    data['contactPerson'] = contactPerson;
    data['address'] = address;
    data['pinCode'] = pinCode;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['area'] = area;
    data['email'] = email;
    data['contactNo'] = contactNo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['createdOn'] = createdOn;
    data['createdBy'] = createdBy;
    data['updatedOn'] = updatedOn;

    return data;
  }
}
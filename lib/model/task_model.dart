class AllTaskModel {
  int? id;
  String? taskType;
  int? customerId;
  String? customerName;
  int? assignTo;
  String? assignToName;
  String? description;
  String? status;
  List<FeedBack>? feedBack;
  String? location;
  DateTime? followUpDate;
  DateTime? createdOn;
  CreatedBy? createdBy;
  String? userName;

  AllTaskModel(
      {this.id,
      this.taskType,
      this.customerId,
      this.customerName,
      this.assignTo,
      this.assignToName,
      this.description,
      this.status,
      this.feedBack,
      this.location,
      this.followUpDate,
      this.createdOn,
      this.createdBy,
      this.userName});

  AllTaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskType = json['taskType'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    assignTo = json['assignTo'];
    assignToName = json['assignToName'];
    description = json['description'];
    status = json['status'];
    if (json['feedBack'] != null) {
      feedBack = <FeedBack>[];
      json['feedBack'].forEach((v) {
        feedBack!.add( FeedBack.fromJson(v));
      });
    }
    location = json['location'];
   followUpDate =json['followUpDate']==null?null: DateTime.parse(json['followUpDate']).toLocal();
    createdOn =json['createdOn']==null?null: DateTime.parse(json['createdOn']).toLocal();
    createdBy = json['createdBy'] != null
        ?  CreatedBy.fromJson(json['createdBy'])
        : null;
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['taskType'] = taskType;
    data['customerId'] = customerId;
    data['customerName'] = customerName;
    data['assignTo'] = assignTo;
    data['assignToName'] = assignToName;
    data['description'] = description;
    data['status'] = status;
    if (feedBack != null) {
      data['feedBack'] = feedBack!.map((v) => v.toJson()).toList();
    }
    data['location'] = location;
    data['followUpDate'] = followUpDate;
    data['createdOn'] = createdOn;
    if (createdBy != null) {
      data['createdBy'] = createdBy!.toJson();
    }
    data['userName'] = userName;
    return data;
  }
}

class FeedBack {
  String? feedback;
  String? createdDate;
  String? createdBy;

  FeedBack({this.feedback, this.createdDate, this.createdBy});

  FeedBack.fromJson(Map<String, dynamic> json) {
    feedback = json['feedback'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['feedback'] = feedback;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    return data;
  }
}

class CreatedBy {
  String? userId;
  String? userName;

  CreatedBy({this.userId, this.userName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['userId'] = userId;
    data['userName'] = userName;
    return data;
  }
}
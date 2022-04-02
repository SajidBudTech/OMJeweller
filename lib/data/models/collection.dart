import 'package:flutter/cupertino.dart';

class Collection{
  int collectionID;
  String addCollectionId;
  String collectionName;
  String collectionImage;
  var collectionStatus;
  String createdAt;
  String updatedAt;
  Collection(
      {this.collectionID,
        this.addCollectionId,
        this.collectionName,
        this.collectionImage,
        this.collectionStatus,
        this.createdAt,
        this.updatedAt});

  Collection.fromJson(Map<String, dynamic> json) {
    collectionID = json['collectionID'];
    addCollectionId = json['add_collection_id'];
    collectionName = json['collectionName'];
    collectionImage = json['collectionImage'];
    collectionStatus = json['collectionStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collectionID'] = this.collectionID;
    data['add_collection_id'] = this.addCollectionId;
    data['collectionName'] = this.collectionName;
    data['collectionImage'] = this.collectionImage;
    data['collectionStatus'] = this.collectionStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
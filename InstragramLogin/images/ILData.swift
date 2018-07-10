//
//  ILData.swift
//
//  Created by Administrator on 7/6/18
//  Copyright (c) instagram. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ILData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let userHasLiked = "user_has_liked"
    static let user = "user"
    static let likes = "likes"
    static let createdTime = "created_time"
    static let tags = "tags"
    static let type = "type"
    static let link = "link"
    static let id = "id"
    static let videos = "videos"
    static let comments = "comments"
    static let usersInPhoto = "users_in_photo"
    static let images = "images"
    static let filter = "filter"
    static let caption = "caption"
  }

  // MARK: Properties
  public var userHasLiked: Bool? = false
  public var user: ILUser?
  public var likes: ILLikes?
  public var createdTime: String?
  public var tags: [Any]?
  public var type: String?
  public var link: String?
  public var id: String?
  public var videos: ILVideos?
  public var comments: ILComments?
  public var usersInPhoto: [Any]?
  public var images: ILImages?
  public var filter: String?
  public var caption: ILCaption?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    userHasLiked = json[SerializationKeys.userHasLiked].boolValue
    user = ILUser(json: json[SerializationKeys.user])
    likes = ILLikes(json: json[SerializationKeys.likes])
    createdTime = json[SerializationKeys.createdTime].string
    if let items = json[SerializationKeys.tags].array { tags = items.map { $0.object} }
    type = json[SerializationKeys.type].string
    link = json[SerializationKeys.link].string
    id = json[SerializationKeys.id].string
    videos = ILVideos(json: json[SerializationKeys.videos])
    comments = ILComments(json: json[SerializationKeys.comments])
    if let items = json[SerializationKeys.usersInPhoto].array { usersInPhoto = items.map { $0.object} }
    images = ILImages(json: json[SerializationKeys.images])
    filter = json[SerializationKeys.filter].string
    caption = ILCaption(json: json[SerializationKeys.caption])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.userHasLiked] = userHasLiked
    if let value = user { dictionary[SerializationKeys.user] = value.dictionaryRepresentation() }
    if let value = likes { dictionary[SerializationKeys.likes] = value.dictionaryRepresentation() }
    if let value = createdTime { dictionary[SerializationKeys.createdTime] = value }
    if let value = tags { dictionary[SerializationKeys.tags] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
    if let value = link { dictionary[SerializationKeys.link] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = videos { dictionary[SerializationKeys.videos] = value.dictionaryRepresentation() }
    if let value = comments { dictionary[SerializationKeys.comments] = value.dictionaryRepresentation() }
    if let value = usersInPhoto { dictionary[SerializationKeys.usersInPhoto] = value }
    if let value = images { dictionary[SerializationKeys.images] = value.dictionaryRepresentation() }
    if let value = filter { dictionary[SerializationKeys.filter] = value }
    if let value = caption { dictionary[SerializationKeys.caption] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.userHasLiked = aDecoder.decodeBool(forKey: SerializationKeys.userHasLiked)
    self.user = aDecoder.decodeObject(forKey: SerializationKeys.user) as? ILUser
    self.likes = aDecoder.decodeObject(forKey: SerializationKeys.likes) as? ILLikes
    self.createdTime = aDecoder.decodeObject(forKey: SerializationKeys.createdTime) as? String
    self.tags = aDecoder.decodeObject(forKey: SerializationKeys.tags) as? [Any]
    self.type = aDecoder.decodeObject(forKey: SerializationKeys.type) as? String
    self.link = aDecoder.decodeObject(forKey: SerializationKeys.link) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.videos = aDecoder.decodeObject(forKey: SerializationKeys.videos) as? ILVideos
    self.comments = aDecoder.decodeObject(forKey: SerializationKeys.comments) as? ILComments
    self.usersInPhoto = aDecoder.decodeObject(forKey: SerializationKeys.usersInPhoto) as? [Any]
    self.images = aDecoder.decodeObject(forKey: SerializationKeys.images) as? ILImages
    self.filter = aDecoder.decodeObject(forKey: SerializationKeys.filter) as? String
    self.caption = aDecoder.decodeObject(forKey: SerializationKeys.caption) as? ILCaption
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(userHasLiked, forKey: SerializationKeys.userHasLiked)
    aCoder.encode(user, forKey: SerializationKeys.user)
    aCoder.encode(likes, forKey: SerializationKeys.likes)
    aCoder.encode(createdTime, forKey: SerializationKeys.createdTime)
    aCoder.encode(tags, forKey: SerializationKeys.tags)
    aCoder.encode(type, forKey: SerializationKeys.type)
    aCoder.encode(link, forKey: SerializationKeys.link)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(videos, forKey: SerializationKeys.videos)
    aCoder.encode(comments, forKey: SerializationKeys.comments)
    aCoder.encode(usersInPhoto, forKey: SerializationKeys.usersInPhoto)
    aCoder.encode(images, forKey: SerializationKeys.images)
    aCoder.encode(filter, forKey: SerializationKeys.filter)
    aCoder.encode(caption, forKey: SerializationKeys.caption)
  }

}

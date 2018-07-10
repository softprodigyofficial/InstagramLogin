//
//  ILFrom.swift
//
//  Created by Administrator on 7/6/18
//  Copyright (c) instagram. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ILFrom: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let fullName = "full_name"
    static let username = "username"
    static let profilePicture = "profile_picture"
  }

  // MARK: Properties
  public var id: String?
  public var fullName: String?
  public var username: String?
  public var profilePicture: String?

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
    id = json[SerializationKeys.id].string
    fullName = json[SerializationKeys.fullName].string
    username = json[SerializationKeys.username].string
    profilePicture = json[SerializationKeys.profilePicture].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = fullName { dictionary[SerializationKeys.fullName] = value }
    if let value = username { dictionary[SerializationKeys.username] = value }
    if let value = profilePicture { dictionary[SerializationKeys.profilePicture] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.fullName = aDecoder.decodeObject(forKey: SerializationKeys.fullName) as? String
    self.username = aDecoder.decodeObject(forKey: SerializationKeys.username) as? String
    self.profilePicture = aDecoder.decodeObject(forKey: SerializationKeys.profilePicture) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(fullName, forKey: SerializationKeys.fullName)
    aCoder.encode(username, forKey: SerializationKeys.username)
    aCoder.encode(profilePicture, forKey: SerializationKeys.profilePicture)
  }

}

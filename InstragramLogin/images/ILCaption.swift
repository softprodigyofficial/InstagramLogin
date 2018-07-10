//
//  ILCaption.swift
//
//  Created by Administrator on 7/6/18
//  Copyright (c) instagram. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ILCaption: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let from = "from"
    static let createdTime = "created_time"
    static let id = "id"
    static let text = "text"
  }

  // MARK: Properties
  public var from: ILFrom?
  public var createdTime: String?
  public var id: String?
  public var text: String?

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
    from = ILFrom(json: json[SerializationKeys.from])
    createdTime = json[SerializationKeys.createdTime].string
    id = json[SerializationKeys.id].string
    text = json[SerializationKeys.text].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = from { dictionary[SerializationKeys.from] = value.dictionaryRepresentation() }
    if let value = createdTime { dictionary[SerializationKeys.createdTime] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = text { dictionary[SerializationKeys.text] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.from = aDecoder.decodeObject(forKey: SerializationKeys.from) as? ILFrom
    self.createdTime = aDecoder.decodeObject(forKey: SerializationKeys.createdTime) as? String
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.text = aDecoder.decodeObject(forKey: SerializationKeys.text) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(from, forKey: SerializationKeys.from)
    aCoder.encode(createdTime, forKey: SerializationKeys.createdTime)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(text, forKey: SerializationKeys.text)
  }

}

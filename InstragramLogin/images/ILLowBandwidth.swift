//
//  ILLowBandwidth.swift
//
//  Created by Administrator on 7/6/18
//  Copyright (c) instagram. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ILLowBandwidth: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let height = "height"
    static let id = "id"
    static let url = "url"
    static let width = "width"
  }

  // MARK: Properties
  public var height: Int?
  public var id: String?
  public var url: String?
  public var width: Int?

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
    height = json[SerializationKeys.height].int
    id = json[SerializationKeys.id].string
    url = json[SerializationKeys.url].string
    width = json[SerializationKeys.width].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = height { dictionary[SerializationKeys.height] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = url { dictionary[SerializationKeys.url] = value }
    if let value = width { dictionary[SerializationKeys.width] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.height = aDecoder.decodeObject(forKey: SerializationKeys.height) as? Int
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? String
    self.url = aDecoder.decodeObject(forKey: SerializationKeys.url) as? String
    self.width = aDecoder.decodeObject(forKey: SerializationKeys.width) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(height, forKey: SerializationKeys.height)
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(url, forKey: SerializationKeys.url)
    aCoder.encode(width, forKey: SerializationKeys.width)
  }

}

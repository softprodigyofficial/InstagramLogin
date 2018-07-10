//
//  ILImages.swift
//
//  Created by Administrator on 7/6/18
//  Copyright (c) instagram. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ILImages: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let standardResolution = "standard_resolution"
    static let thumbnail = "thumbnail"
    static let lowResolution = "low_resolution"
  }

  // MARK: Properties
  public var standardResolution: ILStandardResolution?
  public var thumbnail: ILThumbnail?
  public var lowResolution: ILLowResolution?

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
    standardResolution = ILStandardResolution(json: json[SerializationKeys.standardResolution])
    thumbnail = ILThumbnail(json: json[SerializationKeys.thumbnail])
    lowResolution = ILLowResolution(json: json[SerializationKeys.lowResolution])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = standardResolution { dictionary[SerializationKeys.standardResolution] = value.dictionaryRepresentation() }
    if let value = thumbnail { dictionary[SerializationKeys.thumbnail] = value.dictionaryRepresentation() }
    if let value = lowResolution { dictionary[SerializationKeys.lowResolution] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.standardResolution = aDecoder.decodeObject(forKey: SerializationKeys.standardResolution) as? ILStandardResolution
    self.thumbnail = aDecoder.decodeObject(forKey: SerializationKeys.thumbnail) as? ILThumbnail
    self.lowResolution = aDecoder.decodeObject(forKey: SerializationKeys.lowResolution) as? ILLowResolution
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(standardResolution, forKey: SerializationKeys.standardResolution)
    aCoder.encode(thumbnail, forKey: SerializationKeys.thumbnail)
    aCoder.encode(lowResolution, forKey: SerializationKeys.lowResolution)
  }

}

//
//  ILVideos.swift
//
//  Created by Administrator on 7/6/18
//  Copyright (c) instagram. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ILVideos: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let standardResolution = "standard_resolution"
    static let lowBandwidth = "low_bandwidth"
    static let lowResolution = "low_resolution"
  }

  // MARK: Properties
  public var standardResolution: ILStandardResolution?
  public var lowBandwidth: ILLowBandwidth?
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
    lowBandwidth = ILLowBandwidth(json: json[SerializationKeys.lowBandwidth])
    lowResolution = ILLowResolution(json: json[SerializationKeys.lowResolution])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = standardResolution { dictionary[SerializationKeys.standardResolution] = value.dictionaryRepresentation() }
    if let value = lowBandwidth { dictionary[SerializationKeys.lowBandwidth] = value.dictionaryRepresentation() }
    if let value = lowResolution { dictionary[SerializationKeys.lowResolution] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.standardResolution = aDecoder.decodeObject(forKey: SerializationKeys.standardResolution) as? ILStandardResolution
    self.lowBandwidth = aDecoder.decodeObject(forKey: SerializationKeys.lowBandwidth) as? ILLowBandwidth
    self.lowResolution = aDecoder.decodeObject(forKey: SerializationKeys.lowResolution) as? ILLowResolution
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(standardResolution, forKey: SerializationKeys.standardResolution)
    aCoder.encode(lowBandwidth, forKey: SerializationKeys.lowBandwidth)
    aCoder.encode(lowResolution, forKey: SerializationKeys.lowResolution)
  }

}

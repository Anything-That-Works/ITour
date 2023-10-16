//
//  Sight.swift
//  ITour
//
//  Created by Promal on 16/10/23.
//

import SwiftData

@Model
class Sight {
  var name: String
  init(name: String = "Undefined") {
    self.name = name
  }
}

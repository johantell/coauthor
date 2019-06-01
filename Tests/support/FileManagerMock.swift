import Foundation

@testable import CoauthorLib

class FileManagerMock: FileHandler {
  typealias WriteMethod = (String) throws -> Void

  var currentFileContents: String
  var writeMethod: WriteMethod?

  init(
    initialContents: String = "",
    writeMethod: WriteMethod? = nil
  ) {
    currentFileContents = initialContents
    self.writeMethod = writeMethod
  }

  func read() -> Data {
    return currentFileContents.data(using: .utf8)!
  }

  func readString() -> String {
    return currentFileContents
  }

  func write(contents: String) throws {
    if let method = writeMethod {
      try method(contents)
    }

    currentFileContents = contents
  }
}

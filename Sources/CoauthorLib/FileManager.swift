import Foundation

class FileManager: FileHandler {
  let fileURL: URL

  required init(filePath: String) {
    let absolutePath = NSString(string: filePath).expandingTildeInPath

    fileURL = NSURL.fileURL(withPath: absolutePath)
  }

  func read() -> Data {
    do {
      return try Data(contentsOf: fileURL)
    } catch {
      print("Could not read file: \(fileURL)")
      return Data()
    }
  }

  func readString() -> String {
    let data = read()

    return String(data: data, encoding: .utf8)!
  }

  func write(contents: String) throws {
    let string = "\(contents)\n"

    try string.write(to: fileURL, atomically: false, encoding: .utf8)
  }
}

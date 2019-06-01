import Foundation

protocol FileHandler {
  func read() -> Data
  func readString() -> String
  func write(contents: String) throws
}

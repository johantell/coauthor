public enum LoggingType {
  case normal
  case error
}

public protocol Logger {
  func log(_ message: String)
  func log(_ message: String, type: LoggingType)
}

public class StandardLogger {
  public init() {}
}

extension StandardLogger: Logger {
  public func log(_ message: String) {
    log(message, type: .normal)
  }

  public func log(_ message: String, type: LoggingType = .normal) {
    switch type {
    case .normal:
      print(message)
    case .error:
      print(message)
    }
  }
}

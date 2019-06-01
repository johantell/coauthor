import CoauthorLib

class LoggerMock {
  public var messages: [String] = []
}

extension LoggerMock : Logger {
  func log(_ message: String) {
    log(message, type: .normal)
  }

  func log(_ message: String, type: LoggingType) {
    messages.append(message)
  }
}


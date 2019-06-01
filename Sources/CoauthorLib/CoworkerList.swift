import Foundation

class CoworkerList {
  let fileManager: FileHandler
  let logger: Logger

  lazy var coworkerList: [Coworker] = {
    do {
      let data = fileManager.read()
      let items = try JSONDecoder().decode([Coworker].self, from: data)

      return items
    } catch {
      logger.log("Failed to parse json", type: .error)
      return []
    }
  }()

  init(fileManager: FileHandler, logger: Logger = StandardLogger()) {
    self.fileManager = fileManager
    self.logger = logger
  }

  func addCoworker(_ coworker: Coworker) {
    guard coworkerList.allSatisfy({ $0.username != coworker.username}) else {
      logger.log("Coworker with username `\(coworker.username)` already exist")
      return
    }

    coworkerList.append(coworker)
    writeFile()
  }

  func coworkers() -> [Coworker] {
    return coworkerList
  }

  func removeCoworker(username: String) {
    let listSize = coworkerList.count
    coworkerList.removeAll(where: { $0.username == username })

    if coworkerList.count == listSize {
      logger.log("No user with username `\(username)` could be found.", type: .error)
      return
    }

    writeFile()
  }

  private func writeFile() {
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(coworkerList)
      let jsonString = String(data: data, encoding: .utf8)!
      try fileManager.write(contents: jsonString)
    } catch {
      logger.log("error writing to file", type: .error)
    }
  }
}

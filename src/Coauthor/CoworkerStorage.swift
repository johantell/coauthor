import Foundation

class CoworkerList {
  private lazy var filePath: URL = {
    var path = URL(fileURLWithPath: NSHomeDirectory())
    path.appendPathComponent(".config/coauthor/coauthor.json")

    return path
  }()

  private lazy var coworkersList: [Coworker] = {
    do {
      let jsonData = try Data(contentsOf: filePath)
      let items = try JSONDecoder().decode([Coworker].self, from: jsonData)

      return items
    }
    catch {
      print("failed to read coauthor file")
      return []
    }
  }()

  init() {}


  func addCoworker(_ coworker: Coworker) {
    coworkersList.append(coworker)

    writeFile()
  }

  func coworkers() -> [Coworker] {
    return coworkersList
  }

  func removeCoworker(username: String) {
    let listSize = coworkersList.count
    coworkersList.removeAll(where: { $0.username == username })

    if coworkersList.count == listSize {
      print("No user with username `\(username)` could be found.")
      return
    }

    writeFile()
  }

  private func writeFile() {
    do {
      let encoder = JSONEncoder()
      let data = try encoder.encode(coworkersList)
      let jsonString = String(data: data, encoding: .utf8)!
      try "\(jsonString)\n".write(to: filePath, atomically: false, encoding: .utf8)
    }
    catch {
      print("error writing to file")
    }
  }
}

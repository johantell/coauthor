import Foundation

struct Coworker {
  let username: String
  let name: String
  let email: String
}

extension Coworker: Codable {}

extension Coworker: Hashable {}

class Coauthor {
  init() {}

  func runCommand(arguments: [String]?) {

    guard let args = arguments else { return }

    let inputCommand = InputCommand(arguments: args)

    switch inputCommand {
    case .help:
      print(helpSection)

    case .add:
      let user = initiateAddUser()
      let coworkerList = CoworkerList()

      coworkerList.addCoworker(user)

      print(coworkerList.coworkers())

    case let .remove(username):
      guard let username = username else {
        print("""
              A username must be provided to `remove`:

              coauthor remove [USERNAME]

              Run `coauthor \(InputCommand.list)` to see available users
              """)
        return
      }

      let coworkerList = CoworkerList()
      coworkerList.removeCoworker(username: username)

    case .list:
      let coworkerList = CoworkerList()

      let listString = coworkerList.coworkers().map { coworker in
        "[\(coworker.username)] \(coworker.name) <\(coworker.email)>"
      }

      print(listString.joined(separator: "\n"))

    case let .set(coauthors):
      guard let coauthors = coauthors else { return }

      let coworkerList = CoworkerList()
      let authors = coworkerList.coworkers()
        .filter { coauthors.contains($0.username) }

      let gitCommitTemplate = GitCommitTemplate()

      gitCommitTemplate.setCoauthors(authors)

    case .clear:
      let gitCommitTemplate = GitCommitTemplate()

      gitCommitTemplate.setCoauthors([])

    case let .unknown(command):
      print("No command for `\(command)`.\n")
      print(helpSection)
    }
  }

  private func initiateAddUser() -> Coworker {
    print("Username:")
    let username = readLine()

    print("Full name:")
    let name = readLine()

    print("Email:")
    let email = readLine()

    return Coworker(
      username: username ?? "",
      name: name ?? "",
      email: email ?? ""
    )
  }
}

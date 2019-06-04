import Foundation
import ShellOut

public class Coauthor {
  let logger: Logger
  let helpSection = """
  add                             Starts a prompt to add a coworker to the list of coworkers.
  list                            List all stored coworkers.
  remove [username]               Remove a stored coworker.

  set [username, [username, ...]] Set a list of coauthors.
  current                         Print all active coworkers
  clear                           Clear all coauthors.

  help                            Show this help section.
  """

  public init(logger: Logger = StandardLogger()) {
    self.logger = logger
  }

  public func runCommand(arguments: [String]?) {
    guard let args = arguments else { return }

    let inputCommand = InputCommand(arguments: args)

    switch inputCommand {
    case .help:
      logger.log(helpSection)

    case .add:
      let addedUser = addUser()

      logger.log("successfully added \(addedUser.username)")

    case let .remove(username):
      guard let username = username else {
        logger.log("""
        A username must be provided to `remove`:

        coauthor remove [USERNAME]

        Run `coauthor \(InputCommand.list)` to see available users
        """)
        return
      }

      removeUser(username: username)

    case .list:
      let coworkerList = CoworkerList(fileManager: coauthorStorageFileHandler)

      let listString = coworkerList.coworkers().map { coworker in
        "[\(coworker.username)] \(coworker.name) <\(coworker.email)>"
      }

      logger.log(listString.joined(separator: "\n"))

    case let .set(coauthorUsernames):
      guard let coauthors = coauthorUsernames, coauthors.count > 0 else {
        logger.log("""
        no coauthors specified.

        Run `coauthor \(InputCommand.help)` to see usage manual.
        """, type: .error)

        return
      }

      setCoauthors(coauthors: coauthors)

    case .current:
      let gitCommitTemplate = GitCommitTemplate(
        fileManager: gitCommitTemplateFileManager
      )
      let currentCoworkerEmails = gitCommitTemplate.getCurrentCoauthorEmails()

      guard currentCoworkerEmails.count > 0 else {
        logger.log("There is no active coworkers")
        return
      }

      let coworkerList = CoworkerList(fileManager: coauthorStorageFileHandler)
      let activeCoauthors = coworkerList.coworkers().filter { currentCoworkerEmails.contains($0.email) }

      let coauthorsString = activeCoauthors.map { coauthor in
        "[\(coauthor.username)] \(coauthor.name) <\(coauthor.email)>"
      }.joined(separator: "\n")

      logger.log(coauthorsString)

    case .clear:
      clearCoauthors()

    case let .unknown(command):
      logger.log("No command for `\(command)`.\n", type: .error)
      logger.log(helpSection)
    }
  }

  private lazy var gitCommitTemplateFileManager: FileManager = {
    do {
      let templatePath = try shellOut(
        to: "git",
        arguments: ["config", "--get", "commit.template"]
      )
      let fileManager = FileManager(filePath: templatePath)

      return fileManager
    } catch {
      print("Could not find git template")

      return FileManager(filePath: "~/.config/coauthor/.commit_template")
    }
  }()

  private let coauthorStorageFileHandler: FileManager = FileManager(filePath: "~/.config/coauthor/coauthor.json")

  private func addUser() -> Coworker {
    logger.log("Username:")
    let username = readLine()

    logger.log("Full name:")
    let name = readLine()

    logger.log("Email:")
    let email = readLine()

    let user = Coworker(
      username: username ?? "",
      name: name ?? "",
      email: email ?? ""
    )
    let fileHandler = coauthorStorageFileHandler
    let coworkerList = CoworkerList(fileManager: fileHandler)

    coworkerList.addCoworker(user)

    return user
  }

  private func removeUser(username: String) {
    let coworkerList = CoworkerList(fileManager: coauthorStorageFileHandler)
    coworkerList.removeCoworker(username: username)
  }

  private func setCoauthors(coauthors: [String]) {
    let fileHandler = coauthorStorageFileHandler
    let coworkerList = CoworkerList(fileManager: fileHandler)
    let authors = coworkerList.coworkers()
      .filter { coauthors.contains($0.username) }

    let gitCommitTemplate = GitCommitTemplate(
      fileManager: gitCommitTemplateFileManager
    )

    gitCommitTemplate.setCoauthors(authors)
  }

  private func clearCoauthors() {
    let gitCommitTemplate = GitCommitTemplate(
      fileManager: gitCommitTemplateFileManager
    )

    gitCommitTemplate.setCoauthors([])
  }
}

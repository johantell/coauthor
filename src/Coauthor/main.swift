let helpSection = """
add                 Starts a prompt to add a coworker to the list of coworkers.
list                List all stored coworkers.
remove [username]   Remove a stored coworker.

help                Show this help section.
"""

func main(arguments: [String]?) {
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
      print("a username must be provided to `remove`")
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

  case let .unknown(command):
    print("No command for `\(command)`.\n")
    print(helpSection)
  }
}

main(arguments: CommandLine.arguments)

let helpSection = """
add                 Starts a prompt to add a coworker to the list of coworkers.
list                List all stored coworkers.
remove [username]   Remove a stored coworker.

help                Show this help section.
"""

enum InputCommand {
  case add
  case help
  case list
  case remove(username: String?)
  case unknown(command: String)

  init(arguments: [String]) {
    let command = arguments[safe: 1]

    switch command {
      case "a": self = .add
      case "add": self = .add

      case "l": self = .list
      case "list": self = .list

      case "r": self = .remove(username: arguments[safe: 2])
      case "remove": self = .remove(username: arguments[safe: 2])

      case "h": self = .help
      case "help": self = .help
      case "--help": self = .help
      case nil: self = .help

      default: self = .unknown(command: command!)
    }
  }
}

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

  case .remove(let username):
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


  case .unknown(let command):
    print("No command for `\(command)`.\n")
    print(helpSection)
  }
}

main(arguments: CommandLine.arguments)

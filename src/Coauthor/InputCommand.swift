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

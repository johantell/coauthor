struct Coworker {
  let username: String
  let name: String
  let email: String
}

extension Coworker: Codable {}

extension Coworker: Hashable {}

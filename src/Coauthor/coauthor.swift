import Foundation

struct Coworker {
  let username: String
  let name: String
  let email: String
}

extension Coworker: Codable {}

func initiateAddUser() -> Coworker {
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

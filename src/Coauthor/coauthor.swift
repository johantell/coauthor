import Foundation

struct Coworker : Codable {
  let username: String
  let name: String
  let email: String
}

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

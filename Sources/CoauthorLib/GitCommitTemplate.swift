import Foundation
import ShellOut

class GitCommitTemplate {
  private let fileManager: FileHandler

  private let coauthorSectionIdentifierStart: String = "#--coauthor-start--"
  private let coauthorSectionIdentifierEnd: String = "#--coauthor-end--"

  init(fileManager: FileHandler) {
    self.fileManager = fileManager
  }

  func setCoauthors(_ coauthors: [Coworker]) {
    let templateString = coauthorString(coauthors: coauthors)
    _ = fileManager.read()

    do {
      try fileManager.write(contents: templateString)
    } catch {
      print("Could not write to template file")
    }
  }

  private func coauthorString(coauthors: [Coworker]) -> String {
    let coAuthoredByString = coauthors.map { author in
      "Co-Authored-By: \(author.name) <\(author.email)>"
    }.joined(separator: "\n")

    return """
    \n\n\(coauthorSectionIdentifierStart)
    # Managed by coauthor. Run `coauthor help` for more information.
    \(coAuthoredByString)
    \(coauthorSectionIdentifierEnd)\n
    """
  }
}

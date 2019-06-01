import Foundation
import ShellOut

class GitCommitTemplate {
  // private lazy var templatePath: URL = {
  //   do {
  //     let templatePath = try shellOut(to: "git", arguments: ["config", "--get", "commit.template"])
  //     print("templatePath:", templatePath)

  //     let absoluteURL = NSString(string: templatePath).expandingTildeInPath
  //     let url = NSURL.fileURL(withPath: absoluteURL)

  //     return url
  //   }
  //   catch {
  //     let error = error as! ShellOutError
  //     print("error:", error)

  //     return URL(fileURLWithPath: NSHomeDirectory())
  //   }
  // }()

  private let coauthorSectionIdentifierStart: String = "#--coauthor-start--"
  private let coauthorSectionIdentifierEnd: String = "#--coauthor-end--"

  private let fileManager: FileHandler

  init(fileManager: FileHandler) {
    self.fileManager = fileManager
  }

  static func systemCommitTemplatePath() -> String? {
    do {
      return try shellOut(to: "git", arguments: ["config", "--get", "commit.template"])
    } catch {
      return
    }
  }

  func setCoauthors(_ coauthors: [Coworker]) {
    let templateString = coauthorString(coauthors: coauthors)
    let currentFileContents = fileManager.read()

    fileManager.write(contents: templateString)
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

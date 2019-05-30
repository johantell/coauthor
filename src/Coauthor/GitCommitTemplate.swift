import Foundation
import ShellOut

class GitCommitTemplate {
  private lazy var templatePath: URL = {
    do {
      let templatePath = try shellOut(to: "git", arguments: ["config", "--get", "commit.template"])
      print("templatePath:", templatePath)

      let absoluteURL = NSString(string: templatePath).expandingTildeInPath
      let url = NSURL.fileURL(withPath: absoluteURL)

      return url
    }
    catch {
      let error = error as! ShellOutError
      print("error:", error)

      return URL(fileURLWithPath: NSHomeDirectory())
    }
  }()

  private let coauthorSectionIdentifierStart : String = "#--coauthor-start--"
  private let coauthorSectionIdentifierEnd: String = "#--coauthor-end--"

  func setCoauthors(_ coauthors: [Coworker]) {
    let templateString = coauthorString(coauthors: coauthors)
    let currentFileContents = fileContents()

    write(contents: templateString)
  }

  private func coauthorString(coauthors: [Coworker]) -> String {
      let coAuthoredByString = coauthors.map { author in
        return "Co-Authored-By: \(author.name) <\(author.email)>"
      }.joined(separator: "\n")

      return """
      \n\n\(coauthorSectionIdentifierStart)
      # Managed by coauthor. Run `coauthor help` for more information.
      \(coAuthoredByString)
      \(coauthorSectionIdentifierEnd)\n
      """
  }

  private func fileContents() -> String {
    do {
      let data = try Data(contentsOf: templatePath)

      print(data)

      return String(data: data, encoding: .utf8) ?? ""
    } catch {
      print("Template file could not be read", error)
      return ""
    }
  }

  private func write(contents: String) {
    do {
      try contents.write(to: templatePath, atomically: false, encoding: .utf8)
    } catch {
      print("Could not write to template file")
    }
  }
}

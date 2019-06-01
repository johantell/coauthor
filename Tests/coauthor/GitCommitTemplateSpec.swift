import Nimble
import Quick

@testable import CoauthorLib

class GitCommitTemplateSpec: QuickSpec {
  override func spec() {
    it("updates Co-Authored-By in the passed fileManager") {
      let coauthors = [
        Coworker(username: "johantell", name: "Johan Tell", email: "johan.tell@example.com"),
        Coworker(username: "carlpehrson", name: "Carl Pehrson", email: "carl.pehrson@example.com"),
      ]
      let fileManagerMock = FileManagerMock()
      let gitCommitTemplate = GitCommitTemplate(fileManager: fileManagerMock)

      gitCommitTemplate.setCoauthors(coauthors)

      let contents = fileManagerMock.currentFileContents
      expect(contents).to(contain("Co-Authored-By: Johan Tell <johan.tell@example.com>"))
      expect(contents).to(contain("Co-Authored-By: Carl Pehrson <carl.pehrson@example.com>"))
    }
  }
}

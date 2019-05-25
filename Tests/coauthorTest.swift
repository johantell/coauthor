import Quick
import Nimble

import Coauthor

class CoauthorSpec : QuickSpec {
  let coauthor = Coauthor()

  override func spec() {
    it("") {
      expect(coauthor.runCommand(["help"])).to(equal("hej"))
      expect(2 + 2).to(equal(5))
    }
  }
}

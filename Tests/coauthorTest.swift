import Nimble
import Quick

@testable import CoauthorLib

class CoauthorSpec: QuickSpec {
  override func spec() {
    let loggerMock = LoggerMock()
    let coauthor = Coauthor(logger: loggerMock)

    describe("help") {
      it("prints a help message") {
        coauthor.runCommand(arguments: ["help"])

        expect(loggerMock.messages.count).to(equal(1))
        expect(loggerMock.messages.first).to(contain("add"))
        expect(loggerMock.messages.first).to(contain("list"))
        expect(loggerMock.messages.first).to(contain("remove"))
        expect(loggerMock.messages.first).to(contain("set"))
        expect(loggerMock.messages.first).to(contain("clear"))
        expect(loggerMock.messages.first).to(contain("help"))
      }
    }
  }
}

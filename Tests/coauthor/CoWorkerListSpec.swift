import Nimble
import Quick

@testable import CoauthorLib

class CoworkerListSpec: QuickSpec {
  override func spec() {
    describe("#addCoworker") {
      it("writes a coworker to the coworker storage file") {
        let fileManager = FileManagerMock()
        let coworkerList = CoworkerList(fileManager: fileManager)
        let coworker = Coworker(
          username: "johantell",
          name: "Johan Tell",
          email: "johan.tell@example.com"
        )

        coworkerList.addCoworker(coworker)

        expect(coworkerList.coworkers()).to(equal([coworker]))
        expect(fileManager.currentFileContents).to(
          equal("""
          [{"name":"Johan Tell","username":"johantell","email":"johan.tell@example.com"}]
          """)
        )
      }

      it("keeps any existing coworkers in the coworker storage file") {
        let initialContents = """
        [{"name":"Name 1","username":"name1","email":"email@email.com"}]
        """
        let fileManager = FileManagerMock(initialContents: initialContents)
        let coworkerList = CoworkerList(fileManager: fileManager)
        let coworker = Coworker(
          username: "johantell",
          name: "Johan Tell",
          email: "johan.tell@example.com"
        )

        coworkerList.addCoworker(coworker)

        expect(fileManager.currentFileContents).to(
          equal("""
          [{"name":"Name 1","username":"name1","email":"email@email.com"},{"name":"Johan Tell","username":"johantell","email":"johan.tell@example.com"}]
          """)
        )
      }

      it("doesn't add duplicate usernames to the coworker storage file") {
        let initialContents = """
        [{"name":"Name 1","username":"name1","email":"email@email.com"}]
        """
        let fileManager = FileManagerMock(initialContents: initialContents)
        let loggerMock = LoggerMock()
        let coworkerList = CoworkerList(
          fileManager: fileManager,
          logger: loggerMock
        )
        let coworker = Coworker(
          username: "name1",
          name: "Some name",
          email: "johan.tell@example.com"
        )

        coworkerList.addCoworker(coworker)

        expect(fileManager.currentFileContents).to(
          equal("""
          [{"name":"Name 1","username":"name1","email":"email@email.com"}]
          """)
        )
        expect(loggerMock.messages).to(equal([
          "Coworker with username `name1` already exist",
        ]))
      }

      it("gracefully handles an empty storage file") {
        let fileManager = FileManagerMock()
        let loggerMock = LoggerMock()
        let coworkerList = CoworkerList(
          fileManager: fileManager,
          logger: loggerMock
        )
        let coworker = Coworker(
          username: "johantell",
          name: "Johan Tell",
          email: "johan.tell@example.com"
        )

        coworkerList.addCoworker(coworker)

        expect(fileManager.currentFileContents).to(
          equal("""
          [{"name":"Johan Tell","username":"johantell","email":"johan.tell@example.com"}]
          """)
        )
      }
    }

    describe("removeCoworker") {
      it("removes a coworker to the coworker storage file") {
        let initialContents = """
        [{"name":"Name 1","username":"name1","email":"email@email.com"}]
        """
        let fileManager = FileManagerMock(initialContents: initialContents)
        let coworkerList = CoworkerList(fileManager: fileManager)

        coworkerList.removeCoworker(username: "name1")

        expect(fileManager.currentFileContents).to(equal("[]"))
      }

      it("prints an error when coworker doesn't exist") {
        let initialContents = "[]"
        let fileManager = FileManagerMock(initialContents: initialContents)
        let loggerMock = LoggerMock()
        let coworkerList = CoworkerList(
          fileManager: fileManager,
          logger: loggerMock
        )

        coworkerList.removeCoworker(username: "name1")

        expect(fileManager.currentFileContents).to(equal("[]"))
        expect(loggerMock.messages).to(equal([
          "No user with username `name1` could be found",
        ]))
      }
    }
  }
}

// import Quick
// import Nimble

// import Coauthor

// class GitCommitTemplateSpec : QuickSpec {

//   override func spec() {
//     it("updates Co-Authored-By in the passed") {
//       let coauthors = [
//         Coauthor(username: "johantell", name: "Johan Tell", email: "johan.tell@example.com"),
//         Coauthor(username: "carlpehrson", name: "Carl Pehrson", email: "carl.pehrson@example.com"),
//       ]
//       let templatePath = URL()
//       let gitCommitTemplate = GitCommitTemplate(templatePath: templatePath)

//       gitCommitTemplate.updateCoAuthors(coauthors: coauthors)

//       expect(gitCommitTemplate.contents).to(
//         include("""
//         Co-authored-By: Johan Tell <johan.tell@example.com>
//         Co-authored-By: Carl Pehrson <carl.pehrson@example.com>
//         """)
//       )
//     }
//   }
// }

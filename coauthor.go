package main

import "fmt"
import "os"

func main() {
  args := os.Args
  command := args[1]

  const helpSection = `
  help        Show this help section.
  `

  if command == "help" {
    fmt.Println(helpSection)
  } else {
    commandMissingString := fmt.Sprintf("Command `%s` not found", command)

    fmt.Println(commandMissingString)
    fmt.Println(helpSection)
  }
}

let helpSection = """
add                             Starts a prompt to add a coworker to the list of coworkers.
list                            List all stored coworkers.
remove [username]               Remove a stored coworker.
set [username, [username, ...]] Set a list of coauthors.
clear                           Clear all coauthors.

help                Show this help section.
"""

let coauthor = Coauthor()
coauthor.runCommand(arguments: CommandLine.arguments)

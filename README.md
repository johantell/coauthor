# coauthor
Co-author provides a way to automatically add friends or coworkers as co-authors
to git commits when doing pairing or mob sessions.

## Installation
_To be described_

## Usage
Using coauthor is quite simple, add your coworkers with `coauthor add` and
activate a session by using `coauthor set [username [username ...]]`.

```sh
# Add will prompt for a username, name and email. A tip is to use the your
# private github email ([GITHUB_ID]+[GITHUB_USERNAME]@users.noreply.github.com).
#
# It can also be found at https://github.com/settings/emails.
% coauthor add

# Add `Co-Authored-By` lines for all passed authors stored in your settings
% coauthor set johantell carlpehrson

# Commit
% git commit
```

## Development

```sh
# Run the test suite (It will fetch dependencies automatically)
% swift test
```

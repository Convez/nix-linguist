# NIX-LINGUIST
Nix flake for installing github-linguist

## USAGE
Best usage of this is in conjunction with jq to find the most used language in a repo:

`github-linguist . -j | jq 'to_entries|sort_by(.value.percentage)|reverse|first|.key'`

Or, have a list of languages:
`github-linguist . -j | jq --raw-output 'to_entries|sort_by(.value.percentage)|reverse|map(.key)|@csv|gsub("\"";"")'`

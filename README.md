# NIX-LINGUIST
Nix flake for installing github-linguist

## USAGE
Best usage of this is in conjunction with jq to find the most used language in a repo:
`github-linguist . -j | jq 'to_entries|sort_by(.value.percentage)|reverse|first|.key'`

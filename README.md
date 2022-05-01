# BASH Arguments Parser by @tombh

A quick and convenient way to support arguments in BASH. There are already some other
projects that do exactly this, but of course they weren't quite _exactly_ how I want
it.

Just one small file: copy, paste, `source bash_args_parser.bash` and enjoy 🤓

## Usage:
```bash
declare -A args=(
  [summary]="A short description of what this command or function does"
  [0:foo]="A foo argument, it's positional and required"
  [--bar:flag]="A boolean option that doesn't take a value"
  [--foobar]="An option that requires a value"
)
BAPt_parse_arguments args "$@"

echo "foo is ${args[foo]}. bar is ${args[foo]}. foobar is ${args[foobar]}"
```

`--help` and usage docs are automatically added, eg:
```
Usage: example foo [OPTIONS]

A short description of what this command or function does

Arguments:
  foo      A foo argument, it's positional and required

Options:
  --help   Show help
  --bar    A boolean option that doesn't take a value
  --foobar An option that requires a value
```

Also supports:
* Passing through arguments with an `any` key.
* More detailed usage with a `details` key.
* Can also be used, without changes, inside a function.
```sh
function better_ls {
  local args
  declare -A args=(
    [summary]="List folder contents"
    [any]="The normal \`ls\` arguments"
    [details]="$(
      cat <<-EOM
        Look at all this room!

        Finally I can relax 😎
      EOM
    )"
  )
  BAPt_parse_arguments args "$@"

  if [[ ${args[any]} =~ work ]]; then
    echo "Sorry, you need to be relaxing"
    exit
  else
    "$(ls "${args[any]}")"
  fi
}
```

## Testing

See: https://github.com/pgrange/bash_unit

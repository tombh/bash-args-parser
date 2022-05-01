# shellcheck shell=bash

setup_suite() {
	source '../bash_args_parser.bash'
}

example() {
	local args
	declare -A args=(
		[summary]="A short description of what this command or function does"
		[0:foo]="A foo argument, it's positional and required"
		[--bar]="A boolean option that doesn't take a value"
		[--foobar:flag]="An option that requires a value"
	)
	BAPt_parse_arguments args "$@"

	echo "foo is ${args[foo]}. bar is ${args[bar]}. foobar is ${args[foobar]}"
}


test_happy_path() {
	result=$(example hello --bar world --foobar 2>&1)
	assert_matches "foo is hello" "$result"
	assert_matches "bar is world" "$result"
	assert_matches "foobar is true" "$result"
}

test_failures() {
	assert_fail example --bar world --foobar 2>&1
	result=$(example --bar world --foobar 2>&1)
	assert_matches "Expected 1 got 0" "$result"
	result=$(example hello --bar 2>&1)
	assert_matches "option '--bar' requires an argument" "$result"
}

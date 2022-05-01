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

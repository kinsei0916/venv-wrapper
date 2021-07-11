function venv() {
    if [[ -z $@ ]]; then
        local path=$PWD
        while [[ ! $path -ef / ]]; do
            if [[ $VIRTUAL_ENV -ef $path/.venv ]]; then
                deactivate
                return 0
            elif [[ -f $path/.venv/bin/activate ]]; then
                source $path/.venv/bin/activate
                return 0
            fi
            path="$(readlink -f "$path"/..)"
        done
        echo $'No venv projects found. \'venv create\' to create new project.'
        return 1
    elif [[ $@ == 'create' ]]; then
        python -m venv .venv
    else
        python -m venv $@
    fi
}

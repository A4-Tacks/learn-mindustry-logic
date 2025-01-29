#!/usr/bin/bash
set -o nounset
set -o errtrace
function catch_error {
    local LEC=$? name i line file
    echo "Traceback (most recent call last):" >&2
    for ((i = ${#FUNCNAME[@]} - 1; i >= 0; --i)); do
        name="${FUNCNAME[$i]}"
        line="${BASH_LINENO[$i]}"
        file="${BASH_SOURCE[$i]}"
        echo "  File ${file@Q}, line ${line}, in ${name@Q}" >&2
    done
    echo "Error: [ExitCode: ${LEC}]" >&2
    exit "${LEC}"
}
trap catch_error ERR

function show_help {
    cat <<- EOF
	${0@Q} [-h | --help] <FILE_NAME> <PAGE_NAME>
	EOF
}

if [[ $# -eq 0 || "${1:-}" = @(-h|--help) ]]; then
    show_help
    exit
fi
if [ $# -ne 2 ]; then
    echo "unexpected args count: $#" >&2
    show_help >&2
    exit 2
fi

file_name=${1:?empty FILE_NAME}
page_name=${2:?empty PAGE_NAME}

if command -v bat >/dev/null; then
    function show_file {
        command bat "${1?}"
    }
else
    function show_file {
        local file=${1?}
        echo file: "${file@Q}"
        command cat -n "${file}"
    }
fi

cd "$(dirname -- "${0}")/pages" || exit

index_file=./README.md
target=./pages

show_file "${index_file}"
IFS=$'\n' read -rd '' id line prev < <(awk '
/^- \[[0-9]{2}-/&&/\)$/{
    id=$0
    sub(/^- \[/, "", id); sub(/-.*$/, "", id)
    line=NR
    prev=$0
    sub(/\)$/, "", prev); sub(/^.*\]\(/, "", prev)
}
END{
    printf "%.2d\n", id+1
    print line
    print prev
    printf "\0"
}
' "${index_file}")
build_file=${id:?}-${file_name%.md}.md

echo "${page_name@A}" >&2
echo "${build_file@A}" >&2
echo "${line@A}" >&2
echo "${prev@A}" >&2

if ! { read -N1 -rp '是否确认? [y/Y]' && [[ "${REPLY}" = @(|[yY$'\n']) ]]; } then
    echo
    exit 1
fi
[ "$REPLY" = $'\n' ] || echo

sed -i "\$a[下一章](./$build_file)" "${prev:?}"
sed -i "${line:?}a- [${id:?}-${page_name:?}](./${build_file:?})" "${index_file}"
cat << EOF > "${build_file}"
# ${page_name}


---
[上一章](${prev})
[目录](${index_file})
EOF

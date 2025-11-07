#!/usr/bin/bash
set -o nounset
set -o errtrace
set -o pipefail
function CATCH_ERROR { # {{{
    local __LEC=$? __i __j
    set +x
    echo "Traceback (most recent call last):" >&2
    for ((__i = ${#FUNCNAME[@]} - 1; __i >= 0; --__i)); do
        printf '  File %q line %s in %q\n' >&2 \
            "${BASH_SOURCE[__i]}" \
            "${BASH_LINENO[__i]}" \
            "${FUNCNAME[__i]}"
        if ((BASH_LINENO[__i])) && [ -f "${BASH_SOURCE[__i]}" ]; then
            for ((__j = 0; __j < BASH_LINENO[__i]; ++__j)); do
                read -r REPLY
            done < "${BASH_SOURCE[__i]}"
            printf '    %s\n' "$REPLY" >&2
        fi
    done
    echo "Error: [ExitCode: ${__LEC}]" >&2
    exit "${__LEC}"
}
trap CATCH_ERROR ERR # }}}

hash jq

shopt -s failglob

files=(
    ./README.md
    ./pages/README.md
    ./pages/[0-9][0-9]-*.md
    ./pages/appendix-*.md
)

title_index=$(awk '{sub("^# ", "")}{sub(" ", "-")}
BEGIN{printf"{"}END{printf"}"}
{sub("\\./pages/", "prefix/", FILENAME)}
{sub("\\./", "../", FILENAME)}
{sub("^prefix/", "./", FILENAME)}
i++{printf","}
{printf "\"%s\": \"%s\"", FILENAME, $0}
{nextfile}' "${files[@]}" | jq '.+{"./pages/README.md": .["./README.md"]}')

cat "${files[@]}" | jq -Rr \
    --argjson title "$title_index" \
'
gsub("\\[ (?<desc> [^\\[\\]]+ ) \\] \\s* \\( (?<link> \\. [^()]* ) \\)";
     "[\(.desc)](#\(.link|if contains("#") then
       gsub(".*(?=#)"; "")
     else
       $title[.]//error | ascii_downcase
     end))"
     ;
     "x")
| if sub("^# "; "") as $cur | $title | any(.==$cur) and input_line_number > 5 then
  "", "---", "", .
end
'

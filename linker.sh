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
def page_first:
  sub("^# "; "") as $cur | $title | any(.==$cur) and input_line_number > 4;
reduce inputs as $line ({};
  if $line | page_first then
    .pages += [.current]
    | .current = [$line]
  else .current += [$line | gsub("\\[ (?<desc> [^\\[\\]]+ ) \\] \\s* \\( (?<link> \\. [^()]* ) \\)";
    "[\(.desc)](#\(.link|if contains("#") then
      gsub(".*(?=#)"; "")
    else
      $title[.]//error | ascii_downcase
    end))";
  "x")] end
)
| if .current | length != 0 then .pages += [.current] end
| .pages
| map({lines: ., max_ref: (
    map(scan("\\[ \\^ (\\d+) \\^? \\]"; "x")[0] | tonumber)|max//0
  )})
| foreach .[] as $page (0;
  . as $base |
  ($page.lines[] | gsub("\\[ \\^ (?<n>\\d+) \\^? \\]"; "[^\(.n | tonumber+$base)]"; "x")),
  "", "---", "",
  $base + $page.max_ref
)
| strings
'

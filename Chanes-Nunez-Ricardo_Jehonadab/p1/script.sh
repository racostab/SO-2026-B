function log {
    >&2 echo "$1"
}
function crawl {
    dirs=$(find -s $1 -depth 1 -type d | sort -r)
    prev=""
    for dir in $dirs; do
        #crawl $dir
        prev=$(crawl $dir)
    done
    output=$(ls -lhT $1)
    hash1=$(echo $output | md5)
    hash2=$(echo "$hash1$prev" | md5)
    log "======= $1 :: $hash1 :: $hash2 ========"
    log $prev
    log "=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+"
    log $output
    echo $hash2
}

crawl .

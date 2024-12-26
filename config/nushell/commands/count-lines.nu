def count-lines [lookup_path: path]: nothing -> int {
  glob ($"($lookup_path)/*" | path expand)
    | each {|in| if ($in | path type) == "dir" { 
        count-lines $in
      } else {
        # It doesn't work correctly with binary files like image
        try { open $in --raw | decode utf-8 | lines -s | length } catch { 0 }
    }} 
    | append 0 # For case if the input is empty
    | math sum
}

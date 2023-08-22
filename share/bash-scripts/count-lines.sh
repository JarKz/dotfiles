count=0
function do_count {
	for file in "$1"/*
	do
		if [[ -d $file ]];
		then
			do_count "$file"
		else
			lines=$(wc -l < "$file")
			((count=count+lines))
		fi
	done
}

if [[ $1 == "" ]];
then
  echo "Not given path!"
else
  do_count "$1"
  echo $count
fi


COUNT=0;
while [ true ]
do
	if [ $COUNT -eq 10 ]
	then
		echo "count is 10"
		exit 1;
	fi
	COUNT=$((COUNT+1))
done
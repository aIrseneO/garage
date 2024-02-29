#!/bin/bash

#mkdir git-bisect
#cd git-bisect

#git init

for i in {1..11}; do
	if [[ "$i" -gt "7" ]]; then
		echo -e '#!/bin/bash\nexit 1' > check.sh
	else
		echo -e '#!/bin/bash\nexit 0' > check.sh
	fi
	echo commit $i >> file;
	git add .
	git commit -m "commit $i"
done

#git bisect start

#git bisect bad

#git log # Get the first known good commit <commit ID>

#git bisect good <commit ID>

#git bisect run bash check.sh

# Apply Fix

#git bisect reset

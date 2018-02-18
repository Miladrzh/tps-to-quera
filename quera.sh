#!/bin/bash


# be name khoda
# written by milad ;)

if [ -f Quera_Test.zip ]; then
	rm -rf Quera_Test.zip
fi

if [ -d Quera_Test ]; then
	rm -rf Quera_Test
fi

mkdir Quera_Test
tps gen
mkdir Quera_Test/in
mkdir Quera_Test/out

if [[ -f checker/checker.cpp ]]; then
	echo "Checker Found!"
	cp checker/checker.cpp Quera_Test/tester.cpp
else
	echo "No Checker"
fi

cnt="0"

FILES=tests/*.out
for f in `ls $FILES`
do
	cnt=$(($cnt + 1))
	echo "copying output $cnt"
	cp $f Quera_Test/out/output$cnt.txt
done

cnt="0"

FILES=tests/*.in
for f in `ls $FILES`
do
	cnt=$(($cnt + 1))
	echo "copying input $cnt"
	cp $f Quera_Test/in/input$cnt.txt
done

if [[ -f subtasks.json ]]; then
	if [[ -f config.json ]]; then
		rm -rf config.json
	fi

	touch config.json

	echo '{"packages": [' >> config.json


	all="0"

	for i in {0..10}
	do
		cnt="0"
		FILES=tests/$i*.in
		for f in `ls $FILES`
		do
			cnt=$(($cnt + 1))
			all=$(($all + 1))
		done
		java -jar tpsTOquera.jar $i $all $cnt >> config.json
	done

	echo ']}' >> config.json
	cp config.json Quera_Test/config.json
	rm -rf config.json
else
	echo "No subtasks Set Yet!!!"
fi

cd Quera_Test

if [[ -f config.json && -f tester.cpp ]]; then
	zip -r Quera_Test.zip in out tester.cpp config.json
elif [[ -f config.json ]]; then
	zip -r Quera_Test.zip in out config.json
elif [[ -f tester.cpp ]]; then
	zip -r Quera_Test.zip in out tester.cpp
else
	zip -r Quera_Test.zip in out
fi

cp Quera_Test.zip ../Quera_Test.zip
rm -rf Quera_Test.zip

cd ..


echo "finished!"
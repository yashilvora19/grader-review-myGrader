CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -f ListExamples.java
rm -f TestResults.txt
git clone $1 student-submission
echo 'Finished cloning'

files=`find ./*/*.java`

for file in $files
do 
    if [[ -f ./student-submission/ListExamples.java ]]
    then
        continue
    else
        echo 'File not found'
        exit
    fi
done

mv -v ./student-submission/ListExamples.java ./

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java
if [[ $? == 0 ]]
then
    echo 'Successfully Compiled!'
else
    echo 'Compilation Error'
    exit
fi

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > TestResults.txt


if  grep -q "Tests run" "TestResults.txt" ; then
    echo 'Tests failed: ' ;
    grep -w "Tests run" TestResults.txt 
else
    echo 'All tests passed!' ; 
fi


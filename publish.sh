./test.sh | grep PASSED
echo 'Press any key to publish'
read -n1
./pre-push.hook ; npm publish

cd template/
eval "$(direnv export bash)"

cp ../_package.json package.json
npm i -D '@wdio/cli@latest' '@wdio/local-runner@latest' '@wdio/mocha-framework@latest' '@wdio/spec-reporter@latest' 'chromedriver@latest' 'tsm@latest' 'wdio-chromedriver-service@latest'
./wdio.sh && echo 'TEMPLATE TESTS PASSED' || echo 'TEMPLATE TESTS FAILED'
rm package.json
rm package*lock*
rm -rf node_modules

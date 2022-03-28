cd template/
eval "$(direnv export bash)"

cp ../_package.json package.json
echo 'Installing components'
npm i -D '@wdio/cli@latest' '@wdio/local-runner@latest' '@wdio/mocha-framework@latest' '@wdio/spec-reporter@latest' 'chromedriver@latest' 'tsm@latest' 'wdio-chromedriver-service@latest'
echo 'Running App.tsx'
_wdio_app_tsx="$(docker compose up | grep App.tsx | wc -l)"
echo 'Running EmptyEntrypoint.tsx'
_wdio_emptyentrypoint_tsx="$(docker compose --env-file ../_env up | grep EmptyEntry | wc -l)"
if [[ "$_wdio_app_tsx" == "1" ]]; then
  if [[ "$_wdio_emptyentrypoint_tsx" == "1" ]]; then
    echo 'Running functionality tests'
    ./wdio.sh &&  echo 'TEMPLATE TESTS PASSED' || echo 'TEMPLATE TESTS FAILED: wdio.sh launch fault'
  else
    echo 'TEMPLATE TESTS FAILED: EmptyEntrypoint.tsx launch fault'
  fi
else
  echo 'TEMPLATE TESTS FAILED: App.tsx launch fault'
fi
rm package.json
rm package*lock*
rm -rf node_modules

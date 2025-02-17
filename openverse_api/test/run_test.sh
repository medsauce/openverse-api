#!/bin/bash

red="\e[31m"
green="\e[32m"
endcol="\e[0m"

# Specify a file as the first argument to restrict the test to that file only.
# ```
# $	./test/run_test.sh test/audio_integration_test.py
# ```
TEST_ARG="${1:-test/}"

PYTHONWARNINGS="ignore:Unverified HTTPS request" \
PYTHONPATH=. \
pytest -s --disable-pytest-warnings $TEST_ARG

succeeded=$?
if [[ $succeeded -eq 0 ]]; then
	printf "${green}:-) All tests passed${endcol}\n"
else
  printf "Full system logs:\n"
  docker-compose logs
	printf "${red}:'( Some tests did not pass${endcol}\n"
fi
exit $succeeded

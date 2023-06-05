#!/bin/sh -e

run() {
  docker run --name pg-job-parser -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres:15.3
}

command="$1"
if [ -z "$command" ]
then
 using
 exit 0;
else
 $command $@
fi

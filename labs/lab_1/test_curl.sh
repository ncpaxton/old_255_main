#!/bin/bash
/bin/bash student_setup.sh

curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://localhost:8000/hello?name=Winegar"
curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://localhost:8000/"
curl -o /dev/null -s -w "%{http_code}\n" -X GET "http://localhost:8000/docs"

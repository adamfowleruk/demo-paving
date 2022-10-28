#!/bin/sh
ANNIE_JWT=`cat ../prereqs/annie.jwt`
curl -k -H 'Accept: application/json' -H "Authorization: Bearer ${ANNIE_JWT}" https://a66b517ac82b543fba3b8338a4f77de4-2135436932.us-east-2.elb.amazonaws.com/api/v1/manage/ 
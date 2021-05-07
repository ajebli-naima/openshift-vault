#!/bin/bash
set -e
set -o pipefail

echo "Testing vault integration..."
# Test vault login
vault write auth/kubernetes/login role=backend jwt=eyJhbGciOiJSUzI1NiIsImtpZCI6IjdBVG93b1BYRm1MaktoZVBkVC1scWlCRjdqQmRTc3hUbllWMWFxQ1dLMmcifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJzZWNyZXQtbWFuYWdlbWVudCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkZWZhdWx0LXRva2VuLXZ0YjU4Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImRlZmF1bHQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJjMDc3ZDZjMi04ZWE3LTQ3YzMtOGEyZS1iNGM4MDJjZjk3NDIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6c2VjcmV0LW1hbmFnZW1lbnQ6ZGVmYXVsdCJ9.KFw3FgVfRCiqR7W1CHuLu5ab5b5vcLYekwQ2h39XxycndW-nxocKonHVfzla3TgedjI8d4oCY_n-QMj-pKiOIwZt4-kNx_fRwn5w-6FVR0nJ9-4Ohc62wvfZ8AJnFBQIVArI7SrtfbSI5Xil9OYzdIK6y62DGva8fMLZlBpNIIWt1ea0xsrDEC0HC2Ami0gHhiuTRnX-YTMlPcseUjKYQN_VwnL7x9mMdqwrT2y2Va4CI3OaGDqQziWNVYeN1QZa5z2K4FkqI1xrLabQwFTzlyBvxaXcw6o86yT-0MVoag4ySq0OVP5eX58aneRZyCJL5pyFX-kvWHGZ2jMkX2PiBQ$(oc serviceaccounts get-token default -n secret-management)
# Test service
route=$(oc get route spring-sample-app -o jsonpath={.spec.host})
curl http://$route/health 
curl http://$route/secret 
curl http://$route/addValue -H "Content-Type: application/json" -X POST -d '{"value":"40"}'
curl http://$route/value -H "Content-Type: application/json" -X POST -d '{"value":"40"}'
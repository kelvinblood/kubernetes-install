
#!/bin/bash


if [ ! -n "$1" ]; then
  URL="monocular.local:8879"
else
  URL=$1
fi

helm lint kapua-k8s
helm package kapua-k8s --debug
mv kapua-k8s-*.tgz charts/
helm serve --repo-path ./charts --address 0.0.0.0:8879 --url $URL

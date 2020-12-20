#!/usr/bin/env bash

if [[ -n $TRAVIS_BRANCH ]]; then
  TAG="$(echo $TRAVIS_BRANCH | rev | cut -f1 -d/ | rev)-$TRAVIS_BUILD_NUMBER"
else
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  TAG="$(echo $BRANCH | rev | cut -f1 -d/ | rev)-0"
fi

PORT="8080"
NAME="att-cloudnative/ibmcloud-pattern-guide"

IMAGE="us.icr.io/$NAME:$TAG"

login() {
  if [[ "$1" == icr ]]; then
    ibmcloud cr login
  else
    docker login $1
  fi
}

build() {
  docker build -t $IMAGE .
  [[ $? -eq 0 ]] && echo "[ OK ] the docker image '$IMAGE' have been built locally"
}

deploy() {
  docker push $IMAGE
  [[ $? -ne 0 ]] && return

  # ibmcloud cr image-list
  echo "[ OK ] the docker image '$IMAGE' have been deployed to IBM Cloud Registry"
  echo "[ INFO ] pull the image with tag: $TAG"
  echo "[ INFO ] or execute the command: docker run --rm -p $PORT:80 $IMAGE"
}

run() {
  if [[ $1 == debug ]]; then
    IT="-it "
    echo "[ INFO ] exit from the container with: exit"
  fi
  if [[ -n $2 ]]; then
    IMAGE=$2
    echo "[ INFO ] running docker image '$IMAGE'"
  fi
  echo "[ INFO ] serving the site at: http://localhost:$PORT"
  docker run $IT --rm -p $PORT:80 $IMAGE
}

clean() {
  docker image rm $IMAGE
  [[ $? -eq 0 ]] && echo "[ OK ] the docker image '$IMAGE' have been deleted locally"
}

if [[ $# -lt 1 ]]; then
  echo "USAGE:"
  echo
  echo "$0 ACTION [ACTION ACTION ...]"
  echo
  echo "ACTION:"
  echo "  --build | -b: build the container locally with the web site"
  echo "  --deploy | -d: deploy the container to the IBM Cloud Registry"
  echo "  --deploy-to REGISTRY: deploy the container to the given Docker Registry"
  echo "  --run | -r: runs the container to access the web site"
  echo "  --run-tag | -t TAG: runs the container from the IBM Cloud Registry with the given tag"
  echo "  --debug: run the container and open a shell on it so you can debug the behaviour of the HTTP server"
  echo "  --all: do build, deploy and run"
  echo "  --clean: removes the local docker image"
  echo
  exit 0
fi

while (( "$#" )); do
  case $1 in
    --build | -b)
      build
      ;;
    --login-icr)
      login icr
      ;;
    --deploy | -d)
      deploy
      ;;
    --deploy-to)
      deploy
      ;;
    --run | -r)
      run
      ;;
    --run-tag | -t)
      run _ $2
      shift
      ;;
    --debug)
      run debug
      ;;
    --clean)
      clean
      ;;
    --all)
      build
      deploy
      run
      ;;
  esac
  shift
done

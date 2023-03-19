#podman run -it --rm \
#  --security-opt label=disable \
#  -e "DISPLAY=${DISPLAY}" \
#  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
#  -h 'batman' \
#  gabrielpetry/firefox-java


podman run \
  --rm \
  -it \
  -u 0:0 \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $(pwd)/podman-firefox:/home/firefox:Z \
  --security-opt label=disable \
  -e DISPLAY=${DISPLAY} \
  -h 'batman' \
  localhost/je-firefox
  /usr/bin/firefox \
  -no-remote
  #gabrielpetry/firefox-java

  #--security-opt=label=type:container_runtime_t \
#  --privileged \

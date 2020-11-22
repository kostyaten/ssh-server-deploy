#!/bin/bash
set -e

setup_ssh(){
    SSH_PATH="$HOME/.ssh"
    mkdir -p "$SSH_PATH"
    touch "$SSH_PATH/known_hosts"

    echo "$INPUT_PRIVATE_KEY" > "$SSH_PATH/id_rsa"
    chmod 700 "$SSH_PATH"
    chmod 600 "$SSH_PATH/known_hosts" "$SSH_PATH/id_rsa"
    eval $(ssh-agent)
    ssh-add "$SSH_PATH/id_rsa"
#    ssh-keyscan -t rsa $INPUT_HOST >> "$SSH_PATH/known_hosts"
    echo -n ""
}


if ! [ -z "$INPUT_BEFORE_SCRIPT" ]; then
  CMD="${INPUT_BEFORE_SCRIPT/$'\n'/' && '}"

  if ! [ -z "$INPUT_PASSWORD" ]; then
    sshpass -p $INPUT_PASSWORD ssh -o stricthostkeychecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

  if ! [ -z "$INPUT_PRIVATE_KEY" ]; then
    echo -n "before script start"
    setup_ssh
    echo -n $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD"
    echo -n ""
    ssh -o stricthostkeychecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
    echo -n "before script end"
  fi

fi

if ! [ -z "$INPUT_SCP_SOURCE" ]; then
  sshpass -p $INPUT_PASSWORD scp -o stricthostkeychecking=no -P $INPUT_PORT -r $INPUT_SCP_SOURCE $INPUT_USERNAME@$INPUT_HOST:$INPUT_SCP_TARGET
fi

if ! [ -z "$INPUT_AFTER_SCRIPT" ]; then
  CMD="${INPUT_AFTER_SCRIPT/$'\n'/' && '}"

  if ! [ -z "$INPUT_PASSWORD" ]; then
    sshpass -p $INPUT_PASSWORD ssh -o stricthostkeychecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

  if ! [ -z "$INPUT_PRIVATE_KEY" ]; then
    echo -n "after script start"
    setup_ssh
    ssh -o stricthostkeychecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
    echo -n "after script end"
  fi

fi

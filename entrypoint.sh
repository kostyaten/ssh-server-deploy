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
    echo -n ""
}


if ! [ -z "$INPUT_BEFORE_SCRIPT" ]; then
  CMD="${INPUT_BEFORE_SCRIPT/$'\n'/' && '}"

  if ! [ -z "$INPUT_PASSWORD" ]; then
    sshpass -p $INPUT_PASSWORD ssh -o StrictHostKeyChecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

  if ! [ -z "$INPUT_PRIVATE_KEY" ]; then
    setup_ssh
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD"
  fi

fi

if ! [ -z "$INPUT_SCP_SOURCE" ]; then
  sshpass -p $INPUT_PASSWORD scp -o StrictHostKeyChecking=no -P $INPUT_PORT -r $INPUT_SCP_SOURCE $INPUT_USERNAME@$INPUT_HOST:$INPUT_SCP_TARGET
fi

if ! [ -z "$INPUT_AFTER_SCRIPT" ]; then
  CMD="${INPUT_AFTER_SCRIPT/$'\n'/' && '}"

  if ! [ -z "$INPUT_PASSWORD" ]; then
    sshpass -p $INPUT_PASSWORD ssh -o StrictHostKeyChecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

  if ! [ -z "$INPUT_PRIVATE_KEY" ]; then
    setup_ssh
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

fi

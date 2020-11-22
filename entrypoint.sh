#!/bin/bash
set -e

if ! [ -z "$INPUT_BEFORE_SCRIPT" ]; then
  CMD="${INPUT_BEFORE_SCRIPT/$'\n'/' && '}"

  if ! [ -z "$INPUT_PASSWORD" ]; then
    sshpass -p $INPUT_PASSWORD ssh -o stricthostkeychecking=no -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

  if ! [ -z "$INPUT_PRIVATE_KEY" ]; then
    echo "${INPUT_PRIVATE_KEY}" | ssh -q -i /dev/stdin -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
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
    echo "${INPUT_PRIVATE_KEY}" | ssh -q -i /dev/stdin -p $INPUT_PORT $INPUT_USERNAME@$INPUT_HOST "$CMD";
  fi

fi

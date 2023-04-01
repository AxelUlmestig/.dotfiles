#!/bin/sh

touch ~/.ssh/authorized_keys
cat authorized_keys/* >> ~/.ssh/authorized_keys

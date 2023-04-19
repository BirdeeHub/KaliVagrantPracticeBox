#!/bin/bash
ssh -oHostKeyAlgorithms=+ssh-rsa $1@$2

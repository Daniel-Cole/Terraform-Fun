#!/bin/bash

START=$(date +%s)

terraform apply

END=$(date +%s)
DIFF=$(( $END - $START ))

echo $DIFF > applytime.txt

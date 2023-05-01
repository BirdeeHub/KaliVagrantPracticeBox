#!/bin/bash
##### The following command will pull and run the latest stable image. 
### Remove the -v option if you do not need to preserve your projects between runs
##
docker run -e LANG=C.UTF-8 --memory=8g -p 0.0.0.0:7777:7777 -it "intrigueio/intrigue-core:latest"
##
##
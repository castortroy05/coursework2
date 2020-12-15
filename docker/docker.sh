#! /bin/bash
groupadd docker
usermod -aG docker $USER
addgroup --system docker
adduser $USER docker
newgrp docker

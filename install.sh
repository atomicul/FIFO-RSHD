#!/usr/bin/env bash

CONFIG_FILE='/etc/fifo-rsh/config'
INSTALL_LOCATION='/opt/fifo-rsh'

cd `dirname $0`

mkdir -p "$INSTALL_LOCATION"
cp -r * "$INSTALL_LOCATION"

ln -sf "$INSTALL_LOCATION/fifo-rsh" /usr/local/bin/fifo-rsh

mkdir -p `dirname $CONFIG_FILE`
cat <<'EOF' > $CONFIG_FILE
MASTER_PIPE="master_pipe"
SLAVES=8
SLAVE_FILES_DIRECTORY=fifo
EOF

cat <<EOF > /etc/systemd/system/fifo-rsh.service
[Unit]
Description=Fifo Remote Shell Daemon
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=$INSTALL_LOCATION
ExecStart=$INSTALL_LOCATION/fifo-rshd
Restart=on-failure
Environment="CONFIG_FILE=$CONFIG_FILE"

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable fifo-rsh
systemctl restart fifo-rsh

echo "Done"

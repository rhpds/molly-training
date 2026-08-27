#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Setup vm control01" > /tmp/progress.log

chmod 666 /tmp/progress.log 

#dnf install -y nc

# --- Cockpit (RHEL web console) ---
# Install cockpit
dnf install -y cockpit

# Open the guest firewall for 9090 (Service target)
firewall-cmd --add-service=cockpit --permanent
firewall-cmd --reload

# Enable cockpit functionality in showroom (Edge route + iframe)
echo "[WebService]" > /etc/cockpit/cockpit.conf
echo "Origins = https://cockpit-${GUID}.${DOMAIN}" >> /etc/cockpit/cockpit.conf
echo "AllowUnencrypted = true" >> /etc/cockpit/cockpit.conf

# Enable the socket last, with config in place
systemctl enable --now cockpit.socket
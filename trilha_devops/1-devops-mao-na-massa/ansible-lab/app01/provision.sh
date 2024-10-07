#/bin/sh
mkdir -p /home/vagrant/.ssh
cat << EOT >> /home/vagrant/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDGRnxYFe4rsxiJeYXcDbT0RnXF8Ou42IXpUO7na7NGOl6CzHiRSMSJkXTu7KVxuHL6jfW01AIwJQS/LZsdVrFuasfFjPu7af/+74t+uy77aOrVq6B+6wmkdggQByfkOJKurBvia0b1D550Nkh7hh4+W/LaEveczoZyrLSAkvA8aG6/OCRGAtNOfglEAwaQ8B5/iPuz2HH9V8Qww+4G+lu7pIcsazGUlB7SzBXDXpCPIleT0oeLwbHA4UjxVX8VMqWgJ2R83x5fS5Uo+3GPX4GGWZPRW8yWWnCh6ZaZFxsIigruCJ2XZ4G5fBgQb6+NQ+8HbuBDk4u4+Ie/C+d5A1kP vagrant@control-node
EOT
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
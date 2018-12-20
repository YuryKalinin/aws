sudo apt-get update -y
sudo apt-get install -y nginx git-core qrencode python-virtualenv
git clone https://github.com/chubin/qrenco.de
cd qrenco.de
virtualenv ve/
qrenco.de/ve/bin/pip install -r qrenco.de/requirements.txt 

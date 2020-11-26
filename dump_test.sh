#rm -rf /home/bhowden/dump;
sudo rm xfer/*
sudo mongodump --host 172.28.2.93 -d cii2Test --port 31020 --username admin --password VkcGAgeG0PynWnAqUT00 --authenticationDatabase admin --out ./xfer

#обновление и установка гита
apt update
apt install git
#Ставим поддержку gpio
git clone git clone https://github.com/orangepi-xunlong/wiringOP.git
cd WiringOP
./build clean
./build
cd ..
#rm -R WiringOP

#Копируем скрипт
mkdir -p $HOME/my_scripts/
mkdir -p $HOME/my_scripts/fan_control/
cp cooler_controller.sh $HOME/my_scripts/fan_control/

#Делаем скрипт исполняемым
sudo chmod +x $HOME/my_scripts/fan_control/cooler_controller.sh

#Добавляем пути в юнит
echo "ExecStart="$HOME"/my_scripts/fan_control/cooler_controller.sh" >> cooler_controller.service
echo "
[Install]
WantedBy=multi-user.target" >> cooler_controller.service

#Добавляем юнит
sudo cp cooler_controller.service /etc/systemd/system/
sudo systemctl enable cooler_controller.service

#Чистим файлы
cd ..
rm -R cooler-controller-orangePI/

#Ставим в автозапуск
sudo systemctl enable cooler_controller.service

echo "==============================[ ГОТОВО! ]=============================="
echo "Для проверки статуса службы выполнить комманду:"
echo "	sudo systemctl status cooler_controller.service"
echo "Скрипт установлен в: "
echo "	cd $HOME/my_scripts/fan_control"

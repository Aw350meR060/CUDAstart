# CUDAstart
В данном репозитории хранится инструкция по установке NVIDIA CUDA для Windows и Ubuntu, а так же демо-проекты для тестирования возможностей параллелирования данной технологии.

# Инструкция по установке (Windows)
## Требования к установке:
- Графический процессор с поддержкой CUDA 
- Поддерживаемая версия Microsoft Windows 
- Поддерживаемая версия Microsoft Visual Studio (меньше всего проблем вызывает установка на [Visual Studio 2015](https://my.visualstudio.com/Downloads?q=visual%20studio%202015&wt.mc_id=o~msft~vscom~older-downloads), предварительно необходимо зарегестрироваться) 
- Версия [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-downloads) для вашей ОС + патчи

![alt text](https://github.com/Aw350meR060/CUDAstart/blob/master/CUDA%20Compatibility.jpg)

## Подготовка к установке:
Для начала нужно установить актуальные [драйвера для вашей видеокарты](https://www.nvidia.ru/Download/index.aspx?lang=ru) 

На данный момент актуальная версия CUDA -  9.1.85, которая, к сожалению, не поддерживает последнюю версию компилятора Visual C ++ 15.5. 

## Установка:
1. Запустите установщик CUDA Toolkit, выбрав при этом экспресс установку.
2. Установите прилагающиеся патчи.
3. Откройте Visual Studio и проверьте, появился ли пункт меню "Nsight":
![alt text](https://i.imgur.com/kKZRlsQ.png)
4. Если данное меню не появилось, необходимо перезагрузить ПК и повторить процесс установки CUDA Toolkit, выбрав выборочную установку и оставив лишь пункт "Visual Studio Integration":
![alt text](https://i.imgur.com/B7lnFzC.png)
5. Затем необходимо настроить системные переменные для обнаружения готовых библиотек:
![alt text](https://i.imgur.com/1KuODTN.png)

   PATH:
   
   ![alt text](https://i.imgur.com/y51gWPk.png)

## Проверка:
Проверка состоит в следующем: CUDA поставляется с готовыми проектами. Необходимо выбрать любой из них, открыть решение в Visual Studio, скомпилировать его и запустить.

![alt text](https://i.imgur.com/HqaDmbM.png)
![alt text](https://i.imgur.com/9QsYOfj.png)


# Инструкция по установке (Linux)
Инструкция предполагает, что вы используете Ubuntu, как дистрибутив Linux, но подходит и для других дистрибутивов.

> [Оригинал инструкции](http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions)

## Установка:
1. Установите драйвера для видеокарты по [инструкции](http://help.ubuntu.ru/wiki/драйвер_видеокарт_nvidia)
2. Загрузите [пакет CUDA](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=deblocal) и выполните команды в терминале по инструкции:
>`sudo dpkg -i cuda-repo-ubuntu1604-9-1-local_9.1.85-1_amd64.deb`
>
>`sudo apt-key add /var/cuda-repo-<version>/7fa2af80.pub`
>
>`sudo apt-get update`
>
>`sudo apt-get install cuda`
3. Пропишите системные переменные. Переменная PATH должна включать `/ usr / local / cuda- 9.1 / bin`. Чтобы добавить этот путь к переменной PATH выполните:
>`$ export PATH = / usr / local / cuda- 9.1 / bin $ {PATH: +: $ {PATH}} `

Из-за добавления новых функций, характерных для драйвера NVIDIA POWER9 CUDA, есть некоторые дополнительные требования к настройке, чтобы драйвер работал правильно. Эти дополнительные шаги не обрабатываются установкой пакетов CUDA, и неспособность обеспечить выполнение этих дополнительных требований приведет к неработоспособной установке драйвера CUDA. 

Есть два изменения, которые необходимо выполнить вручную после установки драйвера NVIDIA CUDA для обеспечения правильной работы: 
- Создайте и включите системный файл службы или сценарий инициализации, который запускает демон с сохранением NVIDIA как первое программное обеспечение NVIDIA во время или в конце процесса загрузки. Для большинства установок достаточно использовать следующий пример служебного файла:
>[Unit]
>
>Description=NVIDIA Persistence Daemon
>
>Wants=syslog.target
>
> [Service] 
>
>Type=forking 
>
>PIDFile=/var/run/nvidia-persistenced/nvidia-persistenced.pid 
>
>Restart=always 
>
>ExecStart=/usr/bin/nvidia-persistenced --verbose
>
> ExecStopPost=/bin/rm -rf /var/run/nvidia-persistenced 
>
>[Install] 
>
>WantedBy=multi-user.target 

Скопируйте приведенный выше текст в следующий файл: 
>`/usr/lib/systemd/system/nvidia-persistenced.service` 
И выполните следующую команду:
>`$ systemctl enable nvidia-persistenced `

- Отключите правило udev, установленное по умолчанию в некоторых дистрибутивах Linux, которые автоматически подключаются к горячей замене, когда они физически исследованы. Такое поведение не позволяет программному обеспечению NVIDIA выводить онлайн-память устройства NVIDIA без настроек по умолчанию. Это правило udev должно быть отключено для правильного функционирования драйвера NVIDIA CUDA в системах POWER9. В RedHat Enterprise Linux 7 это правило можно найти в: `/lib/udev/rules.d/40-redhat.rules`; В Ubuntu 17.04 это правило можно найти в: `/lib/udev/rules.d/40-vm-hotadd.rules`. Это правило должно быть прокомментировано, удалено или изменено, чтобы оно не распространялось на системы POWER9 NVIDIA. 

Вам нужно будет перезагрузить систему для инициализации вышеуказанных изменений.

## Проверка
Версию CUDA Toolkit можно проверить, запустив `nvcc -V` в окне терминала. Команда nvcc запускает драйвер компилятора, который компилирует программы CUDA. Он вызывает компилятор gcc для кода C и компилятора NVIDIA PTX для кода CUDA.

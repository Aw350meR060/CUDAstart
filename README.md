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

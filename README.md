# Raylib Docker Development Environment

Контейнер для разработки графических приложений на Raylib с автоматической перекомпиляцией и просмотром в браузере.

## Протестировано на
- Модель: MacBook Pro (14-дюймовый, 2021)
- Чип: Apple M1 Pro
- Память: 16 ГБ
- ОС: macOS Sequoia 15.5
- Браузер: Google Chrome

## Особенности
- Автоматическая компиляция при изменении кода
- Графический вывод через браузер (XPRA)
- Горячая перезагрузка без перезапуска контейнера
- Преднастроенная среда для Raylib v5.0
- Поддержка клавиатурного ввода

## Требования
- Docker + Docker Compose

## Запуск
1. Клонируйте репозиторий:
```bash
git clone https://github.com/your-username/raylib-docker-dev.git
cd raylib-docker-dev
```
2. Запустите систему:
```bash
docker compose up --build
```
3. Для проверки работы, откройте в браузере (проверялось в Google)
```
localhost:10000
```

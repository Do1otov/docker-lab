# Docker: Докеризация приложения (Лабораторная работа №4)

## Цель работы

Собрать из исходного когда и запустить в докере рабочее приложение с базой данных (любое опенсорс - Java, python/django/flask, golang).

1. Образ должен быть легковесным.
2. Использовать базовые легковестные образы - `alpine`.
3. Вся конфигурация приложения должна быть через переменные окружения.
4. Статика (зависимости) должна быть внешним томом `volume`.
5. Создать файл `docker-compose` для старта и сборки.
6. В `docker-compose` нужно использовать базу данных (postgresql, mysql, mongodb etc.).
7. При старте приложения должно быть учтено выполнение автоматических миграций.
8. Контейнер должен запускаться от непривилегированного пользователя.
9. После установки всех нужных утилит, должен очищаться кеш.

## Описание

Это легковесное веб-приложение, разработанное на Python с использованием Django и PostgreSQL в качестве базы данных. Приложение организовано с использованием Docker и Docker Compose.

- **Рабочее приложение:** Django с использованием встроенных ORM и PostgreSQL для работы с базой данных.

- **Легковесные образы:** Используются python:3.10-alpine и postgres:14-alpine.

- **Конфигурация через переменные окружения:** Настройка базы данных выполняется через переменные окружения (POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_HOST, POSTGRES_PORT).

- **Статика во внешнем томе:** Исходный код и зависимости приложения сохраняются в внешнем томе `/myapp`.

- **Создание файла `docker-compose` для старта и сборки:** Используется файл `docker-compose.yml`, который описывает настройку приложения и базы данных, их сборку и запуск.

- **Использование базы данных в `docker-compose`:** В качестве базы данных используется PostgreSQL, подключённый в качестве отдельного сервиса в `docker-compose.yml`.

- **Автоматические миграции:** Выполнение миграций базы данных осуществляется автоматически при запуске приложения.

- **Непривилегированный пользователь:** Приложение запускается от непривилегированного пользователя `appuser`.

- **Очистка кеша:** Используется параметр `--no-cache-dir` при установке зависимостей, а для установки пакетов Alpine задействован `--no-cache`.

## Структура проекта

- **Dockerfile:** Описывает инструкции для сборки Docker-образа, включая установку зависимостей, добавление исходного кода и настройку непривилегированного пользователя.

- **docker-compose.yml:** Конфигурационный файл для Docker Compose, который определяет многоконтейнерное приложение, включая веб-приложение (Django) и базу данных (PostgreSQL).

- **requirements.txt:** Файл со списком зависимостей Python, необходимых для работы приложения.

- **manage.py:** Основной файл управления Django-приложением. Используется для запуска сервера разработки, выполнения миграций и создания суперпользователя.

- **myapp/:** Главная директория Django-проекта:
  - **asgi.py:** Настройки для ASGI-сервера, используемого для поддержки асинхронных запросов.
  - **settings.py:** Конфигурационный файл Django-приложения, включая подключение к базе данных через переменные окружения.
  - **urls.py:** Файл маршрутизации, определяющий URL-адреса и их обработчики.
  - **wsgi.py:** Настройки для WSGI-сервера, используемого для обработки запросов в продакшене.

## Запуск приложения

Сборка и запуск контейнеров:
```
docker-compose up --build
```

Приложение будет доступно по адресу:

http://localhost:8000


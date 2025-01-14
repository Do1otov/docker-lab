# Используем легковесный базовый образ
FROM python:3.10-alpine

# Устанавливаем необходимые системные зависимости
RUN apk add --no-cache gcc musl-dev libpq-dev

# Создаем пользователя, под которым будет работать приложение
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Устанавливаем рабочую директорию
WORKDIR /myapp

# Копируем все файлы в контейнер
COPY . .

# Устанавливаем Python-зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Устанавливаем переменные окружения
ENV PYTHONUNBUFFERED=1

# Команда для запуска приложения
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

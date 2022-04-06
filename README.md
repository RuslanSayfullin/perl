# python_libs_catalog
##### _разработка Sayfullin R.R.


Cервис терминологии и REST API к нему


========================================================================================================================
#Описание ТЗ:

Сервис терминологии оперирует ниже перечисленными сущностями.



Сущность "Справочник" содержит следующие атрибуты:

- идентификатор справочника (глобальный и не зависит от версии)
- наименование
- короткое наименование
- описание
- версия (тип: строка, не может быть пустойуникальная в пределах одного справочника)
- дата начала действия справочника этой версии



Сущность "Элемент справочника"

- идентификатор
- родительский идентификатор
- код элемента (тип: строка, не может быть пустой)
- значение элемента (тип: строка, не может быть пустой)



API должно предоставлять следующие методы:

- получение списка справочников.
- получение списка справочников, актуальных на указанную дату.
- получение элементов заданного справочника текущей версии
- валидация элементов заданного справочника текущей версии
- получение элементов заданного справочника указанной версии
- валидация элемента заданного справочника по указанной версии

В API должен быть предусмотрен постраничный вывод результата (данные должны возвращаться частями по 10 элементов).

К сервису должна иметься GUI административной части, с помощью которой можно добавлять новые справочники, новые версии справочников, указывать дату начала действия и наполнять справочники элементами.

Некоторые подробности намеренно не указаны. Оставляем их на ваше усмотрение.

## Технологии

* Python >= 3.8

## Критерии оценки

* Выполнение требований ТЗ.
* Читаемость программного кода (отступы, разделители и т.д.).
* Адекватность выбора подхода: технологий, конструкций языка.
* Наличие в коде программы комментариев и их содержание.
* Невозможность внесения некорректных данных пользователем.
* Наличие ошибок в программе (не ожиданное поведение, не корректные выходные данные), в том числе возникающих при непредусмотренных действиях пользователей.
* Удобство использования (логичность элементов API и GUI-интерфейса).
* Наличие описания разработанного API с примерами.
========================================================================================================================
Протестировано на ОС Debian 11

Склонируйте репозиторий с помощью git:
https://github.com/RuslanSayfullin/python_libs_catalog.git

Перейти в папку:
$ cd python_libs_catalog

создайте изолированное окружение с помощью команды:
python3 -m venv venv

после активации виртуального окружения выполнить команду:
source venv/bin/activate

Установить зависимости из файла **requirements.txt**:
```bash
pip install -r requirements.txt
```
========================================================================================================================
Выполнить следующие команды:

Перейти в папку:
$ cd catalog

    Команда для создания миграций приложения для базы данных

python3 manage.py makemigrations
python3 manage.py migrate

    Создание суперпользователя

python3 manage.py createsuperuser

Будут выведены следующие выходные данные. Введите требуемое имя пользователя, электронную почту и пароль: по умолчанию почта admin@admin.com пароль: 12345

Username (leave blank to use 'admin'): admin
Email address: admin@admin.com
Password: ********
Password (again): ********
Superuser created successfully.

    Команда для запуска приложения

python manage.py runserver

    Приложение будет доступно по адресу: http://127.0.0.1:8000/
========================================================================================================================
Авторизация на портале.

Реализована авторизация на основе сессий:
перейдите по адресу: http://127.0.0.1:8000/admin и войдите под логином и паролем суперпользователя.
Создайте нового пользователя, например:

username: user1
password: v2xOoQNW

Выйдите из учётной записи суперпользователя.

Чтобы получить токен пользователя:
Request method: GET
URL: http://127.0.0.1:8000/drf-auth/login/
Body:
    username:
    password:

Example:
curl --location --request GET 'http://localhost:8000/drf-auth/login/' \
--form 'username=%username' \
--form 'password=%password'

Реализована авторизация на основе пакета Djoser:
Информация о функционале пакета Djoser, представлена на странице оф. документации,  
https://djoser.readthedocs.io/en/latest/base_endpoints.html


========================================================================================================================
Документация API (автодокументирование на swagger (drf-yasg) доступно по адресу http://127.0.0.1:8000/swagger/ )


Получение списка справочников:

    Request method: GET
    URL: http://localhost:8000/handbook/api/v1/directory/
    Example:
    curl --location --request GET 'http://localhost:8000/handbook/api/v1/directory/'


Чтобы создать Словарь:

    Request method: POST
    URL: http://localhost:8000/handbook/api/v1/directory/
    Header:
        Authorization: Token userToken
    Body:
        short_title: short_title of directory
        title: title of directory
        description: description of directory
        is_actual: False/True
        pub_date: publication date can be set only when poll is created, format: YYYY-MM-DD HH:MM:SS
        updated_at: poll updated_at date, format: YYYY-MM-DD HH:MM:SS
    Example:

curl --location --request POST 'http://localhost:8000/handbook/api/v1/directory/' \
--header 'Authorization: Token %userToken' \
--form 'short_title=%short_title of directory' \
--form 'title=%title of directory' \
--form 'description=%description of directory' \
--form 'is_actual=%False/True' \
--form 'pub_date=%pub_date' \
--form 'updated_at=%updated_date \


Обновить Словарь:

    Request method: PATCH
    URL: http://localhost:8000/handbook/api/v1/directory/[directory_id]/
    Header:
        Authorization: Token userToken
    Param:
        directory_id
    Body:
        short_title: short_title of directory
        title: title of directory
        description: description of directory
        is_actual: False/True
        pub_date: publication date can be set only when poll is created, format: YYYY-MM-DD HH:MM:SS
        updated_at: poll updated_at date, format: YYYY-MM-DD HH:MM:SS
    Example:

curl --location --request PATCH 'http://localhost:8000/handbook/api/v1/directory/[directory_id]/' \
--header 'Authorization: Token %userToken' \
--form 'short_title=%short_title of directory' \
--form 'title=%title of directory' \
--form 'description=%description of directory' \
--form 'is_actual=%False/True' \
--form 'pub_date=%pub_date' \
--form 'updated_at=%updated_date \

Удалить опрос:

    Request method: DELETE
    URL: http://localhost:8000/handbook/api/v1/directorydelete/[directory_id]/
    Header:
        Authorization: Token userToken
    Param:
        poll_id Example:

curl --location --request DELETE 'http://localhost:8000/handbook/api/v1/directorydelete/[directory_id]/' \
--header 'Authorization: Token %userToken'

Посмотреть все опросы:

    Request method: GET
    URL: http://localhost:8000/handbook/api/v1/directory/
    Header:
        Authorization: Token userToken
    Example:

curl --location --request GET 'http://localhost:8000/handbook/api/v1/directory/' \
--header 'Authorization: Token %userToken'


========================================================================================================================
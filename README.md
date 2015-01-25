# hhSQLHomework

1. Получить список organization_form, использующихся в таблице employer отсортированные по убыванию

2. Получить количество работодателей каждой из organization_form, отбросив все organization_form для которых найдено менее 3 записей. Результат отсортировать по убыванию количества найденных записей

3. Получить список переводов (таблица translation, каждый перевод характеризуется уникальным набором полей name, lang, site_id), для которых есть русская версия (lang = ‘RU’), но нет украинской (lang = ‘UA’) и флаг ui установлен в true

4. Для каждого user_id получить самую раннюю (по modification_time) запись в translation_history для которых ui = true и вывести только 10 записей самых ранних по modification_time отсортированных по возрастанию modification_time

set search_path = 'hhschool';

-- 1. Получить список organization_form, использующихся в таблице employer отсортированные по убыванию
select distinct organization_form
from employer
order by organization_form desc;

-- 2. Получить количество работодателей каждой из organization_form, отбросив все organization_form для которых найдено менее 3 записей.
-- Результат отсортировать по убыванию количества найденных записей
select organization_form,
       count(*) as cnt
from employer
group by organization_form
having count(*) >= 3
order by cnt desc;

-- 3. Получить список переводов (таблица translation, каждый перевод характеризуется уникальным набором полей name, lang, site_id),
-- для которых есть русская версия (lang = ‘RU’), но нет украинской (lang = ‘UA’) и флаг ui установлен в true
select *
from translation t
where ui = true
  and lang = 'RU'
  and not exists
    ( select 1
     from translation
     where site_id = t.site_id
       and name = t.name
       and lang = 'UA' 
       --and ui = true
 )
order by name;

-- 4. Для каждого user_id получить самую раннюю (по modification_time) запись в translation_history для которых ui = true 
-- и вывести только 10 записей самых ранних по modification_time отсортированных по возрастанию modification_time

-- !!! В translation_history все user_id is null, поэтому для тестов заполняю рандомом [1, 100]
update translation_history set user_id = floor(random()*(99)+1)

select th.*
from
  ( select user_id,
           min(modification_time) as modification_time
   from translation_history th
   inner join translation t using(site_id, name, lang)
   where ui = true
   group by user_id
   order by modification_time limit 10) as grouped
inner join translation_history th using (user_id,
                                         modification_time);

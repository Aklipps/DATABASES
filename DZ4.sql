
-- Практическое задание по теме “CRUD - операции”

-- Повторить все действия по доработке БД vk.

-- Заполнить новые таблицы.
 
 -- Реализуем таблицу семейного положения

 CREATE TABLE family_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO family_statuses (name) 
  VALUES 
  ('Single'),
  ('Married')
;
 
ALTER TABLE profiles ADD COLUMN family_status_id INT UNSIGNED AFTER hometown;  

UPDATE profiles SET family_status_id = FLOOR(1 + (RAND() * 2));

-- Создание таблицы постов (новостей) и активноси пользователей 
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  autor_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу users или communities
  body TEXT NOT NULL,
  media_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу media
  likes_count INT UNSIGNED DEFAULT 0, 
  created_at DATETIME DEFAULT NOW()
);


-- Дорабатываем тестовые данные
SHOW TABLES;

-- users
SELECT * FROM users LIMIT 10;

-- Корректируем даты
UPDATE users SET updated_at = created_at WHERE updated_at < created_at;

-- profiles
SELECT * FROM profiles LIMIT 10;

-- Удаляем и вновь добавляем user_id
ALTER TABLE profiles DROP COLUMN user_id;
ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED NOT NULL FIRST;

DESC profiles;

   

-- ПЕРВИЧНЫЙ КЛЮЧ
ALTER TABLE profiles DROP COLUMN user_id;
ALTER TABLE profiles ADD COLUMN user_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY FIRST;

-- Тепеть уберём AUTO_INCREMENT
ALTER TABLE profiles MODIFY COLUMN user_id INT UNSIGNED;


-- messages
SELECT * FROM messages LIMIT 10;

-- Определяем случайных отправителей и получателей( БЫЛО ЗАДАНО ФЕЙКЕРОМ НО ВСЕ РАВНО СДЕЛАЕМ)
UPDATE messages SET
  from_user_id = FLOOR(1 + (RAND() * 100)),
  to_user_id = FLOOR(1 + (RAND() * 100))
;

-- media_types
SELECT * FROM media_types LIMIT 10;

TRUNCATE media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio')
;

-- media
SELECT * FROM media LIMIT 10;
UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));
UPDATE media SET filename = CONCAT('https://dropbox/vk/file_', `size`);
UPDATE media SET metadata = CONCAT(
  '{"', 
  'owner', 
  '":"', 
  (SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
   '"}');
   
DESC media;

-- Видим что у столбца metadata неверный тип, меняем на JSON   
ALTER TABLE media MODIFY COLUMN metadata JSON; 

-- friendship
SELECT * FROM friendship LIMIT 10;
UPDATE friendship SET
  user_id = FLOOR(1 + (RAND() * 100)),
  friend_id = FLOOR(1 + (RAND() * 100))
;

DESC friendship;

-- friendship_statuses
SELECT * FROM friendship_statuses;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name)
  VALUES ('Requested'), ('Confirmed'), ('Rejected');
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 3));

-- communities
SELECT * FROM communities LIMIT 10;
DELETE FROM communities WHERE id > 10;

-- communities_users
SELECT * FROM communities_users LIMIT 10;
UPDATE communities_users SET
  community_id = FLOOR(1 + (RAND() * 10)),
  user_id = FLOOR(1 + (RAND() * 100))
;


-- Подобрать сервис который будет служить основой для вашей курсовой работы.

-- https://geekbrains.ru

-- (по желанию) Предложить свою реализацию лайков.

CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу users
  post_id INT UNSIGNED NOT NULL, -- внешний ключ на таблицу posts
  like_status BOOLEAN,
);


 

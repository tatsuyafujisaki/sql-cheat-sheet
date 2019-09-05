DROP VIEW IF EXISTS hiragana_shop;
CREATE TEMP VIEW IF NOT EXISTS hiragana_shop(id) AS SELECT id FROM shop WHERE name GLOB '*[あ-ん]*';

DROP VIEW IF EXISTS katakana_shop;
CREATE TEMP VIEW IF NOT EXISTS katakana_shop(id) AS SELECT id FROM shop WHERE name GLOB '*[ア-ンｱ-ﾝ]*';

DROP VIEW IF EXISTS kanji_shop;
CREATE TEMP VIEW IF NOT EXISTS kanji_shop(id) AS SELECT id FROM shop WHERE name GLOB '*[一-鿏]*';

DROP VIEW IF EXISTS alphabet_shop;
CREATE TEMP VIEW IF NOT EXISTS alphabet_shop(id) AS SELECT id FROM shop WHERE name GLOB '*[a-zA-Zａ-ｚＡ-Ｚ]*';

DROP VIEW IF EXISTS myshop;
CREATE TEMP VIEW IF NOT EXISTS myshop
AS
SELECT shop.*,
ifnull(min(hiragana_shop.id, 1), 0) contains_hiragana,
ifnull(min(katakana_shop.id, 1), 0) contains_katakana,
ifnull(min(kanji_shop.id, 1), 0) contains_kanji,
ifnull(min(alphabet_shop.id, 1), 0) contains_alphabet
FROM shop
LEFT JOIN hiragana_shop ON hiragana_shop.id = shop.id
LEFT JOIN katakana_shop ON katakana_shop.id = shop.id
LEFT JOIN kanji_shop ON kanji_shop.id = shop.id
LEFT JOIN alphabet_shop ON alphabet_shop.id = shop.id;

-- SELECT id, name, contains_hiragana, contains_katakana, contains_kanji, contains_alphabet FROM myshop;

DROP VIEW IF EXISTS myfood;
CREATE TEMP VIEW IF NOT EXISTS myfood
AS
SELECT * FROM food WHERE code IN ('R001','R011','R012','R016','R022','R023','R024','R035','R036','R038','R045','R063');

SELECT myfood.code, myfood.name, count(myshop.id)
FROM myshop
JOIN myfood ON myshop.food = myfood.code
WHERE contains_hiragana = 1 AND contains_katakana = 1 AND contains_kanji = 1 AND contains_alphabet = 1
GROUP BY myfood.code
ORDER BY myfood.code;

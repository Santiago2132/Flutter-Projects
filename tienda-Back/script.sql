CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL
);

CREATE TABLE articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    image_url TEXT NOT NULL
);

CREATE TABLE favorites (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    article_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE
);

-- Inserciones de prueba
INSERT INTO users (username, password_hash) VALUES ('1', '1');
INSERT INTO articles (title, image_url) VALUES ('Artículo 1', 'assets/image1.jpg');
INSERT INTO articles (title, image_url) VALUES ('Artículo 2', 'assets/image2.jpg');
INSERT INTO favorites (user_id, article_id) VALUES (1, 1);




ALTER TABLE articles ADD COLUMN seller TEXT NOT NULL DEFAULT 'Vendedor Default';
ALTER TABLE articles ADD COLUMN rating FLOAT NOT NULL DEFAULT 5.0;
UPDATE articles SET 
    title = 'Memoria RAM', 
    image_url = 'https://audiovisualesdecolombia.com/wp-content/uploads/2019/03/MODULO-DE-MEMORIA-RAM-KINGSTON-TECHNOLOGY-DDR4-4GB-2400MHZ-CL17-288PIN-UDIMM.jpg',
    seller = 'TechStore',
    rating = 4.8
WHERE id = 1;

UPDATE articles SET 
    title = 'Ryzen 5', 
    image_url = 'https://www.infoshopcorp.com/wp-content/uploads/2024/06/4406.png',
    seller = 'CPU World',
    rating = 4.9
WHERE id = 2;

UPDATE articles SET 
    title = 'Gabinete PC', 
    image_url = 'https://bgamer.pro/wp-content/uploads/2022/11/case-antec-1-500x500.jpg',
    seller = 'BGamer',
    rating = 4.7
WHERE id = 3;

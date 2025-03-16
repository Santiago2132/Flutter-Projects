import sqlite3
from werkzeug.security import generate_password_hash

DB_PATH = "db/database.db"

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

new_password = "mi_contraseña_segura"
hashed_password = generate_password_hash(new_password)

cursor.execute("UPDATE users SET password_hash = ? WHERE username = ?", (hashed_password, "test_user"))

conn.commit()
conn.close()

print("Contraseña actualizada correctamente.")

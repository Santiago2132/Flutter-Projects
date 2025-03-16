import sqlite3
DB_PATH = "db/database.db"

conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

def print_table(table_name):
    print(f"\nContenido de la tabla '{table_name}':")
    cursor.execute(f"SELECT * FROM {table_name};")
    rows = cursor.fetchall()
    for row in rows:
        print(row)

tables = ["users", "articles", "favorites"]
for table in tables:
    print_table(table)

conn.close()

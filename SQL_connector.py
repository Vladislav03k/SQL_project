import mysql.connector
from mysql.connector import Error

conn = mysql.connector.connect(host="localhost", user="vladislav03k", passwd="pvn5653341", db="hardware_store")

cursor = conn.cursor()

cursor.execute("SELECT * FROM users LIMIT 5")

print(cursor.description)
print(cursor.fetchall())

for row in cursor.fetchall():
    print(row)

conn.close()
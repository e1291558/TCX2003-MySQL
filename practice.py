import mysql.connector

# Connect to the database
conn = mysql.connector.connect(
    host="localhost",
    user="user",
    password="userpass",
    database="mydb"
)

cursor = conn.cursor()

# Prepare input and output parameters
country = "Singapore"
output_count = 0

# Call stored procedure
ret1, ret2 = cursor.callproc('total', (country, output_count))
print(f"Total students from {ret1}: {ret2}")

cursor.callproc('studentsFrom', (country,))
for result in cursor.stored_results():
    rows = result.fetchall()
    for row in rows:
        print(row)

cursor.execute("SET @var = 2")
cursor.callproc("updateSession")
ret = cursor.execute("SELECT @var")
print("Final session value from Python:", cursor.fetchone()[0])  # Should output 15

# Clean up
cursor.close()
conn.close()

import mysql.connector as mys
from random import randint 
import datetime as date

db = mys.connect(host="localhost", user='root', passwd="root", database="project2")
c = db.cursor()

if db.is_connected():
    print("Connected")

'''
create table Purchases (CUST_ID int primary key, CUTS_NAME varchar(100), TRANSACTION_ID int, BRAND varchar(50), BRAND_ID int, AMOUNT varchar(75), BILLING_DATE date);
'''

# from where you confirmed a car through either method
# i.e after the while loop

c.execute("select * from car_list where car_ID=1001")
placeholder = c.fetchone()
print(placeholder)

try:
    # inputs
    cust_ID = randint(2000, 7000)
    cust_Name = input("Enter namae: ")
    trans_ID = randint(10_00_000, 1_80_00_000)
    brand = placeholder[1]
    car_ID = placeholder[0]
    amount = placeholder[-2]
    billing_date = str(date.datetime.now())[:11]

    record = (cust_ID, cust_Name, trans_ID, brand, car_ID, amount, billing_date)
    # add to table
    c.execute(f"insert into purchases values {record}")
    db.commit()
except:
    print('stopp')


## After confirmation do this

c.execute("select * from purchases")
table = c.fetchall()

for i in table:
    c.execute(f"insert into TABLE2 values {i}")

print("Values added")

c.execute("delete from purchases")
db.commit()

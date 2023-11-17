import mysql.connector as con
from random import randint 
import datetime as date

mydb=con.connect(host='localhost',user='root',password='root', database='VKA_Automobiles')
if mydb.is_connected():
    print('succesfull')

    c = mydb.cursor()
    
# writing data to the table

# functions

##def insert():
##    Car_ID = int(input("Enter car ID: "))
##    Brand = input("Enter brand: ")
##    Model_name = input("Enter model name: ")
##    Engine = input("Enter engine: ")
##    Engine_type = input("Enter engine type: ")
##    Qty_available = int(input("Enter quantity available: "))
##    Type = input("Enter type: ")
##    Colors = input("Enter color: ")
##    Price = input("Enter price: ")
##    Brand_ID = int(input("Enter brand ID: "))
##    c.execute(f"insert into car_list values ({Car_ID}, '{Brand}', '{Model_name}', '{Engine}', '{Engine_type}', {Qty_available}, '{Type}', '{Colors}', '{Price}', {Brand_ID} ) ")
##    mydb.commit()
##    print("Successfully Inserted !")
##
##def update(carID, row, value):
##    c.execute(f"select * from car_list where car_ID={carID}")
##    record = c.fetchone()
##    if row == "A":
##        c.execute(f"update car_list set brand='{value}' where car_ID={carID}")
##    elif row == "B":
##        c.execute(f"update car_list set model_name='{value}' where car_ID={carID}")
##    elif row == "C":
##        c.execute(f"update car_list set engine='{value}' where car_ID={carID}")
##    elif row == "D":
##        c.execute(f"update car_list set engine_type='{value}' where car_ID={carID}")
##    elif row == "E":
##        c.execute(f"update car_list set qty_available={value} where car_ID={carID}")
##    elif row == "F":
##        c.execute(f"update car_list set type='{value}' where car_ID={carID}")
##    elif row == "G":
##        c.execute(f"update car_list set colors='{value}' where car_ID={carID}")
##    elif row == "H":
##        c.execute(f"update car_list set price='{value}' where car_ID={carID}")
##    elif row == "I":
##        c.execute(f"update car_list set brand_id={value} where car_ID={carID}")
##    mydb.commit()
##    print("Successfully Updated !")
##
##def delete():
##    Car_ID = int(input("Enter car ID: "))
##    c.execute(f"delete from car_list where Car_id={Car_ID}")
##    mydb.commit()
##    print("Successfully Deleted !")
##
##def search():
##    carID = int(input("Enter car ID: "))
##    c.execute(f"select * from car_list where car_id={carID}")
##    print(c.fetchone())
##
##print('** WELCOME TO VKA AUTOMOBILES AT YOUR SERVICE **')
##print('Are you an admin ?')
##x = input('YES/NO:').lower()
##
##if x == "yes":
##    password = input("Enter password: ")
##    if password == "401526":
##        username = input("Enter username: ")
##        while True:
##            print("1. Insert data \n2. Update data \n3. Delete data \n4. Search data \n5. Quit \n6. Display Car_list \n7. Display Transaction_history")
##            choice = int(input("Enter function number: "))
##            if choice == 1:  # inserting
##                insert()
##            elif choice == 2:  # updating
##                car_ID = int(input("Enter car ID: "))
##                print("A. Brand\nB. Model Name\nC. Engine\nD. Engine Type\nE. Quantity Available\nF. Type\nG. Colors\nH. Price\nI. Brand ID")
##                choice1 = input("Enter choice: ")
##                value = input("Enter new value: ")
##                update(car_ID, choice1, value)
##            elif choice == 3:  # deleting
##                delete()
##            elif choice == 4:  # searching
##                search()
##            elif choice == 5:  # quit
##                break
##              elif choice == 6: # Display table for car_list
##              c.execute("select * from car_list")
##              for i in c.fetchall():
##                  print(i)
##
##              elif choice ==7: # Display table for Transaction_history
##              c.execute("select * from Transaction_history")
##              for i in c.fetchall():
##                  print(i)
##
x = 'no'
if x == "no":
    y = input("R U customer?: ").lower()
    if y == "no":
        quit()
    elif y == "yes":
        c.execute("select * from car_list")
        for i in c.fetchall():
            print(i)

        while True:
            print('How would you like to proceed?')
            print('1. Search by Car ID \n2. Search by Brand name \n3. Proceed to checkout')

            option = int(input('Enter your option:'))
            if option == 1:
                Car_ID = int(input('Enter Car ID:'))
                c.execute(f'select * from car_list where car_id ={Car_ID}')
                print(c.fetchone())
                print('Do you wish to proceed to billing? Y/N')
                choice = input('Enter choice:')
                # proceed to billing or not
                if choice.lower() == 'y':
                    break
                else:
                    continue

            if option == 2:
                print('1. Lexus \n2. MG Motor \n3. Volvo \n4. Tata \n5. Toyota \n6. Citroen \n7. Mercedes-Benz \n8. Audi')
                choice = input('Enter your choice:')
                try:
                    c.execute(f"select * from car_list where Brand='{choice}'")
                    for i in c.fetchall():
                        print(i)
                    CarID = int(input('Enter Car_ID:'))
                    print('Do you wish to proceed to billing? Y/N')
                    choice = input('Enter choice:')

                    if choice.lower() == 'y':
                        break
                    else:
                        continue

                except:
                    print('brand not found')
                    continue

        # billing
        c.execute(f"select * from car_list where car_ID={Car_ID}")
        table = c.fetchone()
        print(table)

        try:
            # inputs
            CUST_ID = randint(2000, 7000)
            CUST_NAME = input("Enter name: ")
            TRANSACTION_ID = randint(10_00_000, 1_80_00_000)
            BRAND = table[1]
            CAR_ID = table[0]
            AMOUNT = table[-2]
            BILLING_DATE = str(datetime.datetime.now())[:19]

            # add to table
            c.execute(f"insert into Billing_Details values ({CUST_ID},'{CUST_NAME}',{TRANSACTION_ID},'{BRAND}',{CAR_ID},{AMOUNT},'{BILLING_DATE}')")
            mydb.commit()

            c.execute("select * from Billing_details")
        except:
            print('stop')

    # After confirmation do this
    c.execute("select * from Billing_Details")
    Bill_table = c.fetchone()
##    print(Bill_table)
##
##    c.execute(f"insert into Transaction_history values {Bill_table}")
##    mydb.commit()
    if Bill_table is not None:
        print(Bill_table)

        c.execute(f"insert into Transaction_history values{Bill_table}")
        mydb.commit()

        print("Added to Transaction history")

        c.execute("delete from Billing_Details")
        mydb.commit()
    else:
        print("No data to insert into Transaction_history.")

        print("Added to Transaction history")

        c.execute("delete from Billing_Details")
        mydb.commit()

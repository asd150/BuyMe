#Udpate start and end date to match Award.jsp

UPDATE T_Product
SET StartDate = (current_date() - 4), EndDate = (current_date() - 2)
WHERE PID != 0


#!/bin/bash

# בקש מהמשתמש להזין את שמו הפרטי
echo "הזן את שמך הפרטי:"
read first_name

# בקש מהמשתמש להזין את יום הלידה
echo "הזן את יום הלידה (1-31):"
read birth_day

# בקש מהמשתמש להזין את חודש הלידה
echo "הזן את חודש הלידה (1-12):"
read birth_month


#נחינחילחמךל    
# הצג את המידע שהוזן
echo "השם שלך הוא: $first_name"
echo "יום הלידה: $birth_day"
echo "חודש הלידה: $birth_month"
# בקש מהמשתמש להזין את שמו הפרטי
Write-Host "הזן את שמך הפרטי:"
$first_name = Read-Host

# בקש מהמשתמש להזין את יום הלידה
Write-Host "הזן את יום הלידה (1-31):"
$birth_day = Read-Host

# בקש מהמשתמש להזין את חודש הלידה
Write-Host "הזן את חודש הלידה (1-12):"
$birth_month = Read-Host

# הצג את המידע שהוזן
Write-Host "השם שלך הוא: $first_name"
Write-Host "יום הלידה: $birth_day"
Write-Host "חודש הלידה: $birth_month"

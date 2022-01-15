locals {
  instructors = [
    "winegarj@berkeley.edu",
    "crisbenge@berkeley.edu",
    "siduojiang@berkeley.edu"
  ]
  students = [
    "sophiaskowronski@berkeley.edu",
    "abhingare@berkeley.edu",
    "ncpaxton@berkeley.edu",
    "mkarch@berkeley.edu",
    "stemlock@berkeley.edu",
    "dchacon@berkeley.edu",
    "joslateriii@berkeley.edu",
    "mblake@berkeley.edu",
    "vasudev.killada@berkeley.edu",
    "daziff@berkeley.edu",
    "sudhrity@berkeley.edu",
    "jdayer@berkeley.edu",
    "pmotameni@berkeley.edu",
    "ivanwong@berkeley.edu",
    "kklu78@berkeley.edu",
    "danieljryu@berkeley.edu",
    "eugene.shen.y@berkeley.edu",
    "sunitc@berkeley.edu",
    "lucas.brossi@berkeley.edu",
    "sweston@berkeley.edu",
    "jm.stilb@berkeley.edu",
    "li.wanyu@berkeley.edu",
    "heather.pieszala@berkeley.edu",
    "shyu@berkeley.edu",
    "georgerodriguez@berkeley.edu",
    "vikram_mukhi@berkeley.edu",
    "kevinxuan@berkeley.edu",
    "yaoc16@berkeley.edu",
    "zwang2020@berkeley.edu",
    "tals123@berkeley.edu",
    "kngo@berkeley.edu",
    "orgoca@berkeley.edu"
  ]
}

locals {
  email_to_id = { for user in data.azuread_users.users.users : user.mail => user.object_id if user.mail != "" }
}



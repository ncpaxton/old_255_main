locals {
  instructors = [
    "winegarj@berkeley.edu",
    "crisbenge@berkeley.edu",
    "siduojiang@berkeley.edu"
  ]
  students = [
    "mkarch@berkeley.edu",
    "joslateriii@berkeley.edu",
    "ski@berkeley.edu",
    "abhingare@berkeley.edu",
    "ncpaxton@berkeley.edu",
    "stemlock@berkeley.edu",
    "dchacon@berkeley.edu",
    "john.slater@berkeley.edu",
    "mblake@berkeley.edu",
    "v.killada@berkeley.edu",
    "ziff@berkeley.edu",
    "sudhrity@berkeley.edu",
    "jdayer@berkeley.edu",
    "pmotameni@berkeley.edu",
    "ivanwong@berkeley.edu",
    "kklu78@berkeley.edu",
    "danieljryu@berkeley.edu",
    "yuzeng@berkeley.edu",
    "sunitc@berkeley.edu",
    "lbrossi@berkeley.edu",
    "sweston@berkeley.edu",
    "Jm.stilb@berkeley.edu",
    "li.wanyu@berkeley.edu",
    "heather.pieszala@berkeley.edu"
  ]
}

locals {
    email_to_id = { for user in data.azuread_users.users.users : user.mail => user.object_id if user.mail != "" }
}



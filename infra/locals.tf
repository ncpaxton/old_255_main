locals {
  instructors = [
    "winegarj@berkeley.edu",
    "crisbenge@berkeley.edu",
    "siduojiang@berkeley.edu"
  ]
  students = [
    "mkarch@berkeley.edu",
    "joslateriii@berkeley.edu"
  ]
}

locals {
    email_to_id = { for user in data.azuread_users.users.users : user.mail => user.object_id if user.mail != "" }
}
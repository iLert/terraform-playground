resource "ilert_user" "example" {
  first_name = "example"
  last_name  = "example"
  email      = "example@example.com"
}

resource "ilert_user_alert_preference" "a" {
  method    = "EMAIL"
  delay_min = 0
  type      = "HIGH_PRIORITY"
  user {
    id = ilert_user.example.id
  }
}

resource "ilert_user_alert_preference" "b" {
  method    = "PUSH"
  delay_min = 15
  type      = "HIGH_PRIORITY"
  user {
    id = ilert_user.example.id
  }
}

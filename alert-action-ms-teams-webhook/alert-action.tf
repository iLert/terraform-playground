data "ilert_escalation_policy" "default" {
  name = "Default"
}

resource "ilert_alert_source" "example" {
  name = "api-example"
  escalation_policy = data.ilert_escalation_policy.default.id
  integration_type = "API" 
}

resource "ilert_alert_action" "example" {
  name = "microsoft-teams-webhook-example"
  alert_source {
    id = ilert_alert_source.example.id
  }
  connector {
    type = "microsoft_teams_webhook"
  }
  trigger_types = [ "alert-created" ]
}

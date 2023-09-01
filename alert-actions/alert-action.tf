resource "ilert_user" "example" {
  first_name = "example"
  last_name  = "example"
  email      = "example@example.com"
}

resource "ilert_escalation_policy" "example" {
  name = "example"
  escalation_rule {
    escalation_timeout = 15
    user               = ilert_user.example.id
  }
}

resource "ilert_alert_source" "example" {
  name              = "My Grafana Integration for GitHub"
  integration_type  = "GRAFANA"
  escalation_policy = ilert_escalation_policy.example.id
}

resource "ilert_connector" "example" {
  name = "My GitHub Connector"
  type = "github"

  github {
    api_key = "my api key"
  }
}

resource "ilert_alert_action" "example_github" {
  name = "github"

  alert_source {
    id = ilert_alert_source.example.id
  }

  connector {
    id   = ilert_connector.example.id
    type = ilert_connector.example.type
  }

  github {
    owner      = "my org"
    repository = "my repo"
  }

  alert_filter {
    operator = "AND"
    predicate {
      field    = "ALERT_SUMMARY"
      criteria = "CONTAINS_ANY_WORDS"
      value    = "EXAMPLE"
    }
    predicate {
      field    = "ALERT_DETAILS"
      criteria = "CONTAINS_NOT_WORDS"
      value    = "EXAMPLE"
    }
    predicate {
      field    = "ESCALATION_POLICY"
      criteria = "IS_STRING"
      value    = ilert_escalation_policy.example.id
    }
    predicate {
      field    = "ALERT_PRIORITY"
      criteria = "IS_STRING"
      value    = "HIGH"
    }
  }
}

resource "ilert_alert_action" "example_email" {
  name = "email"
  alert_source {
    id = ilert_alert_source.example.id
  }
  connector {
    type = "email"
  }
  email {
    recipients = ["example@example.com"]
    subject    = "alo"
  }
  trigger_types = ["alert-created"]

  alert_filter {
    operator = "OR"
    predicate {
      field    = "ALERT_SUMMARY"
      criteria = "IS_STRING"
      value    = "ALO"
    }
    predicate {
      field    = "ALERT_DETAILS"
      criteria = "IS_NOT_STRING"
      value    = "ALO"
    }
    predicate {
      field    = "ALERT_DETAILS"
      criteria = "MATCHES_REGEX"
      value    = "ALO"
    }
    predicate {
      field    = "ALERT_SUMMARY"
      criteria = "MATCHES_NOT_REGEX"
      value    = "ALO"
    }
  }
}

resource "ilert_alert_action" "example_webhook" {
  name = "webhook"
  alert_source {
    id = ilert_alert_source.example.id
  }
  connector {
    type = "webhook"
  }
  trigger_mode = "MANUAL"
  webhook {
    url = "https://www.google.com/"
  }

  alert_filter {
    operator = "OR"
    predicate {
      field    = "ALERT_SUMMARY"
      criteria = "IS_STRING"
      value    = "EXAMPLE"
    }
    predicate {
      field    = "ALERT_DETAILS"
      criteria = "IS_NOT_STRING"
      value    = "EXAMPLE"
    }
    predicate {
      field    = "ALERT_DETAILS"
      criteria = "MATCHES_REGEX"
      value    = "EXAMPLE"
    }
    predicate {
      field    = "ALERT_SUMMARY"
      criteria = "MATCHES_NOT_REGEX"
      value    = "EXAMPLE"
    }
  }
}

resource "ilert_service" "example" {
  name = "example"
}

resource "ilert_alert_action" "example_automation_rule_new" {
  name = "automation_rule"
  alert_source {
    id = ilert_alert_source.example.id
  }
  connector {
    type = "automation_rule"
  }

  trigger_types = ["alert-created", "alert-acknowledged", "alert-auto-resolved", "alert-resolved"]

  automation_rule {
    alert_type     = "CREATED"
    service_ids    = [ilert_service.example.id]
    service_status = "DEGRADED"
  }
}

resource "ilert_automation_rule" "example_automation_rule_old" {
  alert_type     = "CREATED"
  service_status = "DEGRADED"
  service {
    id = ilert_service.example.id
  }
  alert_source {
    id = ilert_alert_source.example.id
  }
}

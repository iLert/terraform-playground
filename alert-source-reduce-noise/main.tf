data "ilert_escalation_policy" "engineering" {
  name = "Engineering"
}

resource "ilert_support_hour" "engineering" {
  name = "Engineering"
  timezone = "Europe/Berlin"
  support_days {
    monday {
      start = "09:00"
      end = "17:00"
    }
    tuesday {
      start = "09:00"
      end = "17:00"
    }
    wednesday {
      start = "09:00"
      end = "17:00"
    }
    thursday {
      start = "09:00"
      end = "17:00"
    }
    friday {
      start = "09:00"
      end = "17:00"
    }
  }

}

resource "ilert_alert_source" "grafana" {
  integration_type  = "GRAFANA"
  name              = "Grafana"
  escalation_policy = data.ilert_escalation_policy.engineering.id
  routing_template {
    text_template = "{{ title.splitTakeAt(\" \",0) }}"
  }
  support_hours {
    id = ilert_support_hour.engineering.id
  }
  alert_priority_rule = "HIGH_DURING_SUPPORT_HOURS"
  priority_template {
    value_template {
      text_template = "{{ state }}"
    }
    mapping {
      value = "alerting"
      priority = "HIGH"
    }
    mapping {
      value = "pending"
      priority = "LOW"
    }
  }
  event_filter = "(event.customDetails.title in [\"FIRING\"])"
  alert_creation = "INTELLIGENT_GROUPING"
  score_threshold = "0.75"
  alert_grouping_window = "PT1H" # 1 hour
  auto_resolution_timeout = "PT6H" # 6 hours
}

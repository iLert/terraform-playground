resource "ilert_call_flow" "call_flow" {
  name     = "Call Flow Demo"
  language = "en"
  root_node {
    node_type = "ROOT"
    branches {
      branch_type = "ANSWERED"
      target {
        node_type = "CREATE_ALERT"
        metadata {
          alert_source_id = -1
        }
      }
    }
  }
}

resource "ilert_call_flow" "business_hours_support" {
  name     = "Business Hours Support"
  language = "en"

  root_node {
    node_type = "ROOT"

    branches {
      branch_type = "ANSWERED"

      target {
        node_type = "AUDIO_MESSAGE"
        metadata {
          text_message   = "Thank you for calling <company name>."
          ai_voice_model = "emma"
        }

        branches {
          branch_type = "CATCH_ALL"

          target {
            node_type = "SUPPORT_HOURS"
            metadata {
              support_hours_id = -1
            }

            branches {
              branch_type = "BRANCH"
              condition   = "context.supportHoursState == 'OUTSIDE'"

              target {
                node_type = "VOICEMAIL"
                metadata {
                  text_message   = "You've reached us outside of our business hours. Please leave your name, contact information, and a brief message, and we'll get back to you during our next business day. Thank you!"
                  ai_voice_model = "emma"
                }

                branches {
                  branch_type = "BRANCH"
                  condition   = "context.recordedMessageUrl != null"

                  target {
                    node_type = "CREATE_ALERT"
                    metadata {
                      alert_source_id = -1
                    }
                  }
                }
              }
            }

            branches {
              branch_type = "BRANCH"
              condition   = "context.supportHoursState == 'DURING'"

              target {
                node_type = "ROUTE_CALL"
                metadata {
                  call_style = "ORDERED"
                  targets {
                    type   = "USER"
                    target = "..." // user id
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}


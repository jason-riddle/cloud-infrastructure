resource "aws_lex_intent" "lex_intent" {
  name           = "LexIntent"
  description    = "LexIntentDescription"
  create_version = true

  fulfillment_activity {
    type = "ReturnIntent"
  }
}

output "lex_intent_arn" {
  value = aws_lex_intent.lex_intent.arn
}

output "lex_intent_version" {
  value = aws_lex_intent.lex_intent.version
}

resource "aws_lex_bot" "lex_bot" {
  name           = "ChatBot"
  description    = "ChatBotDescription"
  create_version = false

  child_directed   = false
  process_behavior = "SAVE"

  abort_statement {
    message {
      content      = "Sorry, I need to exit my program."
      content_type = "PlainText"
    }
  }

  clarification_prompt {
    max_attempts = 2

    message {
      content      = "I didn't understand, can you clarify?"
      content_type = "PlainText"
    }
  }

  intent {
    intent_name    = "LexIntent"
    intent_version = aws_lex_intent.lex_intent.version
  }
}

output "lex_bot_id" {
  value = aws_lex_bot.lex_bot.id
}

output "lex_bot_version" {
  value = aws_lex_bot.lex_bot.version
}

resource "aws_lex_slot_type" "lex_slot_type" {
  name           = "LexSlotType"
  description    = "LexSlotTypeDescription"
  create_version = true

  value_selection_strategy = "ORIGINAL_VALUE"

  enumeration_value {
    synonyms = [
      "Lirium",
      "Martagon",
    ]

    value = "lilies"
  }
}

resource "aws_lex_bot_alias" "lex_bot_alias" {
  name        = "ChatBotAliasName"
  description = "ChatBotAliasDescription"

  bot_name    = "ChatBot"
  bot_version = aws_lex_bot.lex_bot.version
}

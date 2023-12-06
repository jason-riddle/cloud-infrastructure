resource "aws_lex_intent" "lex_intent" {
  name           = "LexIntent"
  description    = "LexIntentDescription"
  create_version = true

  fulfillment_activity {
    type = "ReturnIntent"
  }

  confirmation_prompt {
    max_attempts = 2

    message {
      content      = "Okay, your {FlowerType} will be ready for pickup tomorrow. Does this sound okay?"
      content_type = "PlainText"
    }
  }

  rejection_statement {
    message {
      content      = "Okay, I will not place your order."
      content_type = "PlainText"
    }
  }

  sample_utterances = [
    "I would like to order some flowers",
    "I would like to pick up flowers",
  ]

  slot {
    name        = "FlowerType"
    description = "The type of flowers to pick up"
    priority    = 1

    sample_utterances = [
      "I would like to order {FlowerType}",
    ]

    slot_type         = "LexSlotType"
    slot_type_version = aws_lex_slot_type.lex_slot_type.version
    slot_constraint   = "Required"

    value_elicitation_prompt {
      max_attempts = 2

      message {
        content      = "What type of flowers would you like to order?"
        content_type = "PlainText"
      }
    }
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

  locale = "en-US"

  child_directed   = false
  process_behavior = "BUILD"

  clarification_prompt {
    max_attempts = 2

    message {
      content      = "I didn't understand, can you clarify?"
      content_type = "PlainText"
    }
  }

  abort_statement {
    message {
      content      = "Sorry, I need to exit."
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

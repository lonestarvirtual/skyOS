# frozen_string_literal: true

PaperTrail.config.enabled = true
PaperTrail.config.has_paper_trail_defaults = {
    on: %i[create update destroy]
}
PaperTrail.config.version_limit = 10

# Action Text Compatibility
ActiveSupport.on_load(:action_text_rich_text) do
  ActionText::RichText.class_eval do
    has_paper_trail
  end
end
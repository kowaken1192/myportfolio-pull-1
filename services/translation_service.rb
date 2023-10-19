require "google/cloud/translate"

translate = Google::Cloud::Translate.new version: :v2
text = "こんにちは"
target_language = "en"

translation = translate.translate text, to: target_language
puts translation.text

# https://railsguides.jp/generators.html
Rails.application.config.generators do |g|
  g.test_framework :test_unit,
    fixture_replacement: :factory_girl
end
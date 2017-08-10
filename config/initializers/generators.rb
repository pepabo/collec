# https://railsguides.jp/generators.html
Rails.application.config.generators do |g|
  g.test_framework :rspec,
    fixture_replacement: :factory_girl
end

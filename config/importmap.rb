pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@rails/ujs", to: "rails-ujs.js"
pin_all_from "app/javascript/controllers", under: "controllers"

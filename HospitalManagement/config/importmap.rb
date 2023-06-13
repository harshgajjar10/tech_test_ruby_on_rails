# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@6.0.5/lib/assets/compiled/rails-ujs.js"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js", preload: true
pin "jquery-ui", to: "https://cdn.jsdelivr.net/npm/jquery-ui@1.13.1/ui/widget.js", preload: true
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.esm.js", preload: true
pin "@popperjs/core", to: "https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/lib/index.js", preload: true
pin "fontawesome", to: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/js/all.min.js", preload: true
pin "bootstrap-datepicker", to: "https://cdn.jsdelivr.net/npm/bootstrap-datepicker@1.9.0/dist/js/bootstrap-datepicker.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers", preload: true

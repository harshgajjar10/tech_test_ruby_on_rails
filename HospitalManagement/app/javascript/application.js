// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"; 
Turbo.session.drive = false
import Rails from "@rails/ujs"
Rails.start();
import "jquery";
import "controllers"
import "jquery-ui"
import "bootstrap"
import "@popperjs/core"
import "fontawesome"
import "bootstrap-datepicker"
import "./custom"

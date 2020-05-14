// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "bootstrap"
import "cookieconsent/src/cookieconsent"
import "@fortawesome/fontawesome-free/js/all"
import "leaflet/dist/leaflet.css"

import "../stylesheets/application";

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require("custom/cookieconsent")

// Enable Bootstrap4 tooltips
//
document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="tooltip"]').popover()
})

// Stimulus configuration
//
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const controllers = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(controllers))

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)



require("trix")
require("@rails/actiontext")
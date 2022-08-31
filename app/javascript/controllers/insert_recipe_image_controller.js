import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-recipe-image"
export default class extends Controller {
  static targets = ["uploaded-image"]
  connect() {

  }

  upload() {
    console.log('Coucou')
  }
}

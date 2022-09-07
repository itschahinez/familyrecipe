import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = [ 'navitem' ]

  toggle() {
    this.navitemTarget.classList.toggle('d-none')
  }
}

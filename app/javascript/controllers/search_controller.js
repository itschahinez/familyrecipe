import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["input", "form", "autocomplete"]

  connect() {
    console.log("Welcome to search!");
  }

  submit(event) {
    this.inputTarget.value = event["path"][0].innerText
    this.formTarget.requestSubmit()
  }
}

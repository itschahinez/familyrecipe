import { Controller } from "@hotwired/stimulus"
import insert_recipe_image_controller from "./insert_recipe_image_controller";

export default class extends Controller {

  static targets = ["input", "form", "autocomplete"]

  connect() {
    console.log("hey, I'm search!");
  }

  submit(event) {
    this.inputTarget.value = event["path"][0].innerText
    this.formTarget.requestSubmit()
  }
}

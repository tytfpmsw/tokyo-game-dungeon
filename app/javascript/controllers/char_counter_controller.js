import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "field", "count" ]

  static values = { characterCountMax: Number }

  connect() {
    let length = this.fieldTarget.value.length
    this.countTarget.textContent = `現在${length}文字`
  }

  change() {
    let length = this.fieldTarget.value.length
    this.countTarget.textContent = `現在${length}文字`

    if (length > this.characterCountMaxValue) {
      console.log("over")
      this.countTarget.classList.add("text-danger")
    } else {
      this.countTarget.classList.remove("text-danger")
    }
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "field", "count" ]

  static values = { characterCountMax: Number }

  connect() {
    let length = this.fieldTarget.value.length
    // valueの改行の数をカウント
    let lineBreaks = (this.fieldTarget.value.match(/\n/g) || []).length
    let count = length + lineBreaks
    this.countTarget.textContent = `現在${count}文字`
  }

  change() {
    let length = this.fieldTarget.value.length
    let lineBreaks = (this.fieldTarget.value.match(/\n/g) || []).length
    let count = length + lineBreaks
    this.countTarget.textContent = `現在${count}文字`

    if (count > this.characterCountMaxValue) {
      console.log("over")
      this.countTarget.classList.add("text-danger")
    } else {
      this.countTarget.classList.remove("text-danger")
    }
  }
}
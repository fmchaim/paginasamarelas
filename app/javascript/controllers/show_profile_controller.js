import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-profile"
export default class extends Controller {
    static targets = ["profileElement"]

    connect() {
        console.log("hello from show profile controller")
        console.log(this.profileElementTarget)

    }

    show() {
        this.profileElementTarget.classList.toggle("d-none")
    }
}
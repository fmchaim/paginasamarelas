import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-services"
export default class extends Controller {

    static targets = ["serviceElement"]

    connect() {
        console.log("hello from show services controller")
        console.log(this.serviceElementTarget)

    }

    show() {
        this.serviceElementTarget.classList.toggle("d-none")
    }
}
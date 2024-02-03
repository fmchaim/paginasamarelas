import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-contracts"
export default class extends Controller {

    static targets = ["contractElement"]

    connect() {
        console.log("hello from show contracts controller")
        console.log(this.contractElementTarget)
    }
    show() {
        this.contractElementTarget.classList.toggle("d-none")
        console.log("cliquei")
    }
}
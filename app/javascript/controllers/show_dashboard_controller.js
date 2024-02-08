import { Controller } from "@hotwired/stimulus"


export default class extends Controller {

    static targets = ["serviceElement", "contractElement", "profileElement", "reviewElement"]

    connect() {
        console.log("hello from show services controller")
        console.log(this.serviceElementTarget)

    }

    profile() {
        this.contractElementTarget.classList.add("d-none")
        this.serviceElementTarget.classList.add("d-none")
        this.reviewElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.remove("d-none")
    }

    services() {
        this.contractElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.add("d-none")
        this.reviewElementTarget.classList.add("d-none")
        this.serviceElementTarget.classList.remove("d-none")
    }

    contracts() {
        this.serviceElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.add("d-none")
        this.reviewElementTarget.classList.add("d-none")
        this.contractElementTarget.classList.remove("d-none")

    }

    reviews() {
        this.serviceElementTarget.classList.add("d-none")
        this.profileElementTarget.classList.add("d-none")
        this.contractElementTarget.classList.add("d-none")
        this.reviewElementTarget.classList.add("d-none")
        this.reviewElementTarget.classList.remove("d-none")
    }

}
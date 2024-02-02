import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-services"
export default class extends Controller {
    connect() {
        console.log("hello from show services controller")
    }


}
// app/javascript/controllers/search_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "term" ]

  search(e) {
    e.preventDefault();
    const searchTerm = this.termTarget.textContent;
    window.location.href = `/services?search=${encodeURIComponent(searchTerm)}`;
  }
}

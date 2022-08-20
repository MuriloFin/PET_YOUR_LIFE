import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["pet"]

  selectType(e){
    console.log(e)
  }

  connect() {
    console.log(this.petTarget)
  }
}

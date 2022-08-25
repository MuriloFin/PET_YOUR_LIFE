import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["petSelect", "breedSelect"]
  static values = { data: Object }

  selectPet() {
    if (this.petSelectTarget.value == "Dog") {
      let htmlDogs = ''
      this.dataValue.dog.forEach(dogBreed => {
        htmlDogs+=`<option value="${dogBreed}">${dogBreed}</option>`
      })
      this.breedSelectTarget.innerHTML = htmlDogs
    } else {
      let htmlCats = ''
      this.dataValue.cat.forEach(catBreed => {
        htmlCats+=`<option value="${catBreed}">${catBreed}</option>`
      })
      this.breedSelectTarget.innerHTML = htmlCats
    }
  }
}

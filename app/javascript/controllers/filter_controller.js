import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["petSelect", "breedSelect"]
  static values = { data: Object }

  selectPet() {
    console.log(this.dataValue)
    if (this.petSelectTarget.value == "Cachorro") {
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
  selectPetForm(event) {
    if (event.target.value == "Cachorro") {
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

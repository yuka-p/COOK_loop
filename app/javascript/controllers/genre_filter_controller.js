// app/javascript/controllers/genre_filter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  switch(event) {
    event.preventDefault()

    const genre = event.currentTarget.dataset.genre
    const checked = Array.from(document.querySelectorAll("input[name='menu_ids[]']:checked"))
                        .map(el => el.value)

    const url = new URL("/master_menus", window.location.origin)
    if (genre) url.searchParams.set("genre", genre)
    checked.forEach(id => url.searchParams.append("menu_ids[]", id))

    window.location.href = url.toString()
  }
}
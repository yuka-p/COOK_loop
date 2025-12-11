// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./master_menus"

document.addEventListener("turbo:load", () => {
  if (document.querySelector("[data-controller='meal-plans-new']")) {
    import("./meal_plan")
  }
})
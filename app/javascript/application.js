// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./master_menus"

document.addEventListener("turbo:load", () => {
  if (document.querySelector("[data-controller='meal-plans-new']")) {
    import("./meal_plan")
  }
})

document.addEventListener("turbo:load", () => {
  const button = document.getElementById("toggle-meal-plan");
  const area = document.getElementById("meal-plan-area");

  if (!button || !area) return;

  button.addEventListener("click", () => {
    if (area.classList.contains("hidden")) {
      area.classList.remove("hidden");
      button.textContent = "献立を非表示";
    } else {
      area.classList.add("hidden");
      button.textContent = "献立を表示";
    }
  });
});

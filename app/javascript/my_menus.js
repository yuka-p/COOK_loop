document.addEventListener("turbo:load", () => {
  const form = document.getElementById("filterForm");
  if (!form) return;

  const genreButtons = document.querySelectorAll(".genre-filter-button");
  const genreInput = document.getElementById("genreInput");
  const sortSelect = document.getElementById("sortSelect");

  let activeGenre = "all";

  genreButtons.forEach(button => {
    button.addEventListener("click", () => {
      const genre = button.dataset.genre;
      genreInput.value = genre;

      genreButtons.forEach(b => {
        b.classList.remove("btn-primary");
        b.classList.add("btn-outline");
      });
      button.classList.remove("btn-outline");
      button.classList.add("btn-primary");

      form.requestSubmit();
    });
  });

  sortSelect.addEventListener("change", () => {
    form.requestSubmit();
  });
});

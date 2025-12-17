document.addEventListener("turbo:load", () => {
  const root = document.querySelector("[data-controller='meal-plans-new']");
  if (!root) return;

  const checkboxes = root.querySelectorAll(".menu-checkbox");
  const genreButtons = root.querySelectorAll(".genre-filter-button");
  const menuItems = root.querySelectorAll(".menu-item");

  const counters = {
    main: document.getElementById("count-main"),
    side: document.getElementById("count-side"),
    soup: document.getElementById("count-soup"),
    staple: document.getElementById("count-staple"),
    other: document.getElementById("count-other"),
  };

  /* ===== カウンター ===== */
  function updateCounters() {
    const counts = { main: 0, side: 0, soup: 0, staple: 0, other: 0 };
    checkboxes.forEach(cb => {
      if (cb.checked) counts[cb.dataset.genre]++;
    });
    Object.keys(counters).forEach(k => {
      if (counters[k]) counters[k].textContent = counts[k];
    });
  }

  checkboxes.forEach(cb =>
    cb.addEventListener("change", updateCounters)
  );
  updateCounters();

  /* ===== ジャンルフィルタ ===== */
  genreButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const genre = btn.dataset.genre;

      genreButtons.forEach(b => {
        b.classList.toggle("btn-primary", b === btn);
        b.classList.toggle("btn-outline", b !== btn);
      });

      menuItems.forEach(item => {
        item.style.display =
          genre === "all" || item.dataset.genre === genre
            ? "flex"
            : "none";
      });
    });
  });
});

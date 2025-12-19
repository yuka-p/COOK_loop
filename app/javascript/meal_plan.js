document.addEventListener("turbo:load", () => {
  const root = document.querySelector("[data-controller='meal-plans-new']");
  if (!root) return;

  const checkboxes = root.querySelectorAll(".menu-checkbox");
  const genreButtons = root.querySelectorAll(".genre-filter-button");
  const tagButtons = root.querySelectorAll(".tag-filter-button");
  const menuItems = Array.from(root.querySelectorAll(".menu-item"));
  const sortSelect = document.getElementById("sortSelect");

  let activeGenre = "all";
  const activeTags = new Set();

  /* ===== カウンター ===== */
  const counters = {
    main: document.getElementById("count-main"),
    side: document.getElementById("count-side"),
    soup: document.getElementById("count-soup"),
    staple: document.getElementById("count-staple"),
    other: document.getElementById("count-other"),
  };

  function updateCounters() {
    const counts = { main: 0, side: 0, soup: 0, staple: 0, other: 0 };
    checkboxes.forEach(cb => {
      if (cb.checked) counts[cb.dataset.genre]++;
    });
    Object.keys(counters).forEach(k => {
      counters[k].textContent = counts[k];
    });
  }

  checkboxes.forEach(cb =>
    cb.addEventListener("change", updateCounters)
  );
  updateCounters();

  /* ===== ジャンル ===== */
  genreButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      activeGenre = btn.dataset.genre;

      genreButtons.forEach(b => {
        b.classList.toggle("btn-primary", b === btn);
        b.classList.toggle("btn-outline", b !== btn);
      });

      applyFilters();
    });
  });

  /* ===== タグ（重ねがけ） ===== */
  tagButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const tagId = btn.dataset.tagId;

      btn.classList.toggle("btn-primary");
      btn.classList.toggle("btn-outline");

      activeTags.has(tagId)
        ? activeTags.delete(tagId)
        : activeTags.add(tagId);

      applyFilters();
    });
  });

  /* ===== 並び替え（MyMenu準拠） ===== */
  sortSelect?.addEventListener("change", () => {
    const value = sortSelect.value;
    const list = menuItems[0]?.parentNode;

    const sorted = [...menuItems].sort((a, b) => {
      switch (value) {
        case "created_desc":
          return b.dataset.created - a.dataset.created;
        case "last_cooked_desc":
          return a.dataset.lastCooked - b.dataset.lastCooked;
        case "title_asc":
          return a.dataset.title.localeCompare(b.dataset.title, "ja");
        default:
          return 0;
      }
    });

    sorted.forEach(el => list.appendChild(el));
  });

  /* ===== フィルター適用 ===== */
  function applyFilters() {
    menuItems.forEach(item => {
      const genreOk =
        activeGenre === "all" || item.dataset.genre === activeGenre;

      const tags = item.dataset.tags.split(",").filter(Boolean);
      const tagsOk =
        activeTags.size === 0 ||
        [...activeTags].every(t => tags.includes(t));

      item.style.display = genreOk && tagsOk ? "flex" : "none";
    });
  }
});

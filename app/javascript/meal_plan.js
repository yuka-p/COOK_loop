document.addEventListener("turbo:load", () => {
  const root = document.querySelector("[data-controller='meal-plans-new']");
  if (!root) return;

  const checkboxes = root.querySelectorAll(".menu-checkbox");
  const genreButtons = root.querySelectorAll(".genre-filter-button");
  const tagButtons = root.querySelectorAll(".tag-filter-button");
  const menuItems = Array.from(root.querySelectorAll(".menu-item"));
  const sortSelects = document.querySelectorAll(".js-sort-select");

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
      if (!cb.checked) return;
      const genre = cb.closest(".menu-item")?.dataset.genre;
      if (genre) counts[genre]++;
    });
    Object.entries(counters).forEach(([key, el]) => {
      if (!el) return;
      const count = counts[key];
      el.textContent = count || "";
      el.classList.toggle("hidden", count === 0);
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

  /* ===== タグ ===== */
  tagButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const tagId = btn.dataset.tagId;

      if (activeTags.has(tagId)) {
        activeTags.delete(tagId);
        btn.classList.remove("is-active");
      } else {
        activeTags.add(tagId);
        btn.classList.add("is-active");
      }

      applyFilters();
    });
  });

  /* ===== 並び替え ===== */
  function sortItems(selectedValue) { // 引数で選択された値を受け取るように変更
    if (sortSelects.length === 0) return;

    const list = menuItems[0]?.parentNode;
    const value = selectedValue || sortSelects[0].value; // 値の決定

    const sorted = [...menuItems].sort((a, b) => {
      switch (value) {
        case "created_desc":
          return Number(b.dataset.created) - Number(a.dataset.created);
        case "last_cooked_desc":
          return Number(a.dataset.lastCooked) - Number(b.dataset.lastCooked);
        case "title_asc":
          return a.dataset.title.localeCompare(b.dataset.title, "ja");
        default:
          return 0;
      }
    });

    sorted.forEach(el => list.appendChild(el));
  }

  // すべての並び替えセレクトボックスにイベントを設定し、値を同期させる
  sortSelects.forEach(select => {
    select.addEventListener("change", (e) => {
      const value = e.target.value;
      // PC用・スマホ用両方のセレクトボックスの表示の値を合わせる
      sortSelects.forEach(s => s.value = value);
      sortItems(value);
    });
  });

  /* ===== フィルター ===== */
  function applyFilters() {
    menuItems.forEach(item => {
      const genreOk =
        activeGenre === "all" || item.dataset.genre === activeGenre;

      const tags = item.dataset.tags ? item.dataset.tags.split(",") : [];
      const tagsOk =
        activeTags.size === 0 ||
        [...activeTags].every(t => tags.includes(t));

      item.style.display = genreOk && tagsOk ? "block" : "none";
    });
  }

  /* ===== 初期状態 ===== */
  genreButtons.forEach(btn => {
    btn.classList.toggle("btn-primary", btn.dataset.genre === "all");
    btn.classList.toggle("btn-outline", btn.dataset.genre !== "all");
  });

  if (sortSelects.length > 0) {
    sortSelects.forEach(s => s.value = "last_cooked_desc");
    sortItems("last_cooked_desc");
  }

  applyFilters();
});

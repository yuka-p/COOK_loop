document.addEventListener("turbo:load", () => {
  const checkboxes = document.querySelectorAll(".menu-checkbox");
  const genreButtons = document.querySelectorAll(".genre-filter-button");

  // フィルター状態（複数可）
  let activeFilters = new Set();

  // フィルタリング処理
  function applyFilters() {
    checkboxes.forEach((cb) => {
      const outerBox = cb.closest(".p-4.border.rounded.shadow"); // ← ここが重要
      const genre = cb.dataset.genre;

      if (!outerBox) return;

      // フィルタ何も選ばれていない → 全表示
      if (activeFilters.size === 0) {
        outerBox.style.display = ""; // ← 枠ごと表示
        return;
      }

      // 該当ジャンルなら表示、それ以外は非表示
      if (activeFilters.has(genre)) {
        outerBox.style.display = "";
      } else {
        outerBox.style.display = "none"; // ← 枠ごと消える！
      }
    });
  }

  // ジャンルボタンのクリック処理
  genreButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const genre = btn.dataset.genre;

      // 選択切り替え
      if (activeFilters.has(genre)) {
        activeFilters.delete(genre);
        btn.classList.remove("btn-primary");
        btn.classList.add("btn-outline");
      } else {
        activeFilters.add(genre);
        btn.classList.add("btn-primary");
        btn.classList.remove("btn-outline");
      }

      applyFilters();
    });
  });
});

document.addEventListener("turbo:load", () => {
  const cards = document.querySelectorAll(".menu-card");
  const genreButtons = document.querySelectorAll(".genre-filter-button");

  let activeGenre = "all";

  // ===== カードの選択トグル =====
  cards.forEach((card) => {
    card.addEventListener("click", () => {
      card.classList.toggle("ring-2");
      card.classList.toggle("ring-primary");
      card.classList.toggle("bg-primary/20");
    });
  });

  // ===== フィルタ処理 =====
  function applyFilters() {
    cards.forEach((card) => {
      const genre = card.dataset.genre;

      if (activeGenre === "all" || genre === activeGenre) {
        card.style.display = "";
      } else {
        card.style.display = "none";
      }
    });
  }

  // ===== ジャンルボタン =====
  genreButtons.forEach((btn) => {
    btn.addEventListener("click", () => {
      const genre = btn.dataset.genre;

      // ボタンの見た目リセット
      genreButtons.forEach((b) => {
        b.classList.remove("btn-primary");
        b.classList.add("btn-outline");
      });

      // 押されたボタンだけアクティブ
      btn.classList.add("btn-primary");
      btn.classList.remove("btn-outline");

      activeGenre = genre;
      applyFilters();
    });
  });

  // 初期表示
  applyFilters();
});

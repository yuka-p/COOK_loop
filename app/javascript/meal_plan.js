console.log("meal_plans/new.js LOADED!");

document.addEventListener("turbo:load", () => {
  // ページ内に data-controller="meal-plans-new" が存在するか確認
  if (!document.querySelector("[data-controller='meal-plans-new']")) return;

  console.log("meal-plans-new controller FOUND!");

  const checkboxes = document.querySelectorAll(".menu-checkbox");
  const modal = document.getElementById("confirmModal");
  const openBtn = document.getElementById("openConfirmModal");
  const closeBtn = document.getElementById("closeModal");
  const modalContent = document.getElementById("modalContent");

  const counters = {
    main: document.getElementById("count-main"),
    side: document.getElementById("count-side"),
    soup: document.getElementById("count-soup"),
    staple: document.getElementById("count-staple"),
    other: document.getElementById("count-other"),
  };

  // カウント更新
  function updateCounts() {
    const counts = { main: 0, side: 0, soup: 0, staple: 0, other: 0 };

    checkboxes.forEach((cb) => {
      if (cb.checked) {
        const genre = cb.dataset.genre;
        counts[genre] = (counts[genre] || 0) + 1;
      }
    });

    Object.keys(counters).forEach((g) => {
      counters[g].textContent = counts[g] || 0;
    });
  }

  checkboxes.forEach((cb) => cb.addEventListener("change", updateCounts));

  // モーダル表示
  openBtn?.addEventListener("click", (e) => {
    e.preventDefault();
    modalContent.innerHTML = "";

    checkboxes.forEach((cb) => {
      if (cb.checked) {
        modalContent.insertAdjacentHTML(
          "beforeend",
          `<li>${cb.dataset.menuTitle}（${cb.dataset.genreLabel}）</li>`
        );
      }
    });

    modal.showModal();
  });

  closeBtn?.addEventListener("click", () => modal.close());
});

document.addEventListener("turbo:load", () => {
  const checkboxes = document.querySelectorAll(".menu-checkbox");
  const genreButtons = document.querySelectorAll(".genre-filter-button");
  const menuItems = document.querySelectorAll(".menu-item");

  const counters = {
    main: document.getElementById("count-main"),
    side: document.getElementById("count-side"),
    soup: document.getElementById("count-soup"),
    staple: document.getElementById("count-staple"),
    other: document.getElementById("count-other"),
  };

  // カウンター更新
  function updateCounters() {
    const counts = { main: 0, side: 0, soup: 0, staple: 0, other: 0 };
    checkboxes.forEach(cb => {
      if (cb.checked) {
        counts[cb.dataset.genre] = (counts[cb.dataset.genre] || 0) + 1;
      }
    });
    Object.keys(counters).forEach(key => {
      counters[key].textContent = counts[key] || 0;
    });
  }
  checkboxes.forEach(cb => cb.addEventListener("change", updateCounters));

  // ジャンルフィルタ
  genreButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const genre = btn.dataset.genre;
      genreButtons.forEach(b => {
        b.classList.remove("btn-primary");
        b.classList.add("btn-outline");
      });
      btn.classList.remove("btn-outline");
      btn.classList.add("btn-primary");

      menuItems.forEach(item => {
        if (genre === "all" || item.dataset.genre === genre) {
          item.style.display = "flex";
        } else {
          item.style.display = "none";
        }
      });
    });
  });

  // モーダル表示
  const openModalBtn = document.getElementById("openConfirmModal");
  openModalBtn.addEventListener("click", (e) => {
    e.preventDefault();

    // 選択済みメニューを集める
    const selectedMenus = [];
    checkboxes.forEach(cb => {
      if (cb.checked) {
        selectedMenus.push({
          id: cb.value,
          title: cb.dataset.menuTitle,
          genre: cb.dataset.genreLabel
        });
      }
    });

    // Turbo Frameに描画
    const turboFrame = document.querySelector("turbo-frame#modal");
    let html = `
      <div class="modal-overlay fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white p-6 rounded shadow-lg w-96">
          <h2 class="text-xl font-bold mb-4">登録内容確認</h2>
          <ul class="list-disc ml-6 mb-4">
            ${selectedMenus.map(m => `<li>${m.title}（${m.genre}）</li>`).join("")}
          </ul>
          <div class="text-right">
            <form method="post" action="/meal_plans" data-turbo-frame="_top">
              ${selectedMenus.map(m => `<input type="hidden" name="meal_plan[my_menu_ids][]" value="${m.id}">`).join("")}
              <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded mr-2">登録する</button>
            </form>
            <button type="button" onclick="this.closest('.modal-overlay').remove()" class="bg-gray-300 px-4 py-2 rounded">キャンセル</button>
          </div>
        </div>
      </div>
    `;
    turboFrame.innerHTML = html;
  });
});
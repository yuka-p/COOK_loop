document.addEventListener("turbo:load", () => {
  const form = document.getElementById("filterForm");
  if (!form) return;

  const genreButtons = document.querySelectorAll(".genre-filter-button");
  const genreInput = document.getElementById("genreInput");
  const sortSelect = document.getElementById("sortSelect");

  const tagButtons = document.querySelectorAll(".tag-filter-button");
  const tagInput = document.getElementById("tagIdsInput");

  const activeTags = new Set(
    tagInput?.value ? tagInput.value.split(",") : []
  );

  /* ===== ジャンル ===== */
  genreButtons.forEach(button => {
    button.addEventListener("click", () => {
      const genre = button.dataset.genre;
      genreInput.value = genre;

      genreButtons.forEach(b => {
        b.classList.remove("btn-primary");
        b.classList.add("btn-outline");
      });
      button.classList.add("btn-primary");
      button.classList.remove("btn-outline");

      form.requestSubmit();
    });
  });

  /* ===== 並び替え ===== */
  sortSelect?.addEventListener("change", () => {
    form.requestSubmit();
  });

  /* ===== タグ（トグル） ===== */
   tagButtons.forEach(btn => {
    if (activeTags.has(btn.dataset.tagId)) {
      btn.classList.add("is-active");
    }
  });

  tagButtons.forEach(btn => {
    btn.addEventListener("click", () => {
      const tagId = btn.dataset.tagId;

      btn.classList.toggle("is-active");

      activeTags.has(tagId)
        ? activeTags.delete(tagId)
        : activeTags.add(tagId);

      tagInput.value = [...activeTags].join(",");
      form.requestSubmit();
    });
  });
});


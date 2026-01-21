module.exports = {
  content: [
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        mytheme: {
          primary: "#e8cbb1",
          secondary: "#f3e4d7",
          accent: "#ddbfa3",
          neutral: "#6b4f3f",
          "base-100": "#ffffff",
        },
      },
    ],
  },
};

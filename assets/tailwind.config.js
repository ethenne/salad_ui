// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

module.exports = {
  presets: [
    require("./js/moon-ui-base-preset"),
    require("./js/moon-components"),
  ],
  content: [
    "../../../config/*.*exs",
    "../lib/**/*.ex",
  ],
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/typography"),
    require("tailwindcss-animate"),
  ],
};

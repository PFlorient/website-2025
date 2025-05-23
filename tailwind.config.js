/** @type {import('tailwindcss').Config} */
export default {
  content: [],
  theme: {
    extend: {
      colors: {
        primary: "var(--primary-color)",
        secondary: "var(--white)",
      },
      fontFamily: {
        neueMetana: ["Neue-Metana", "sans-serif"],
        lato: ["Lato", "sans-serif"],
      },
      spacing: {
        "1/10": "10%",
      },
    },
  },
  plugins: [],
};

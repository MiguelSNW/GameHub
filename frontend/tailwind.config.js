/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {  fontFamily: {
      never: ['Never', 'sans-serif'],
    },},
  },
  plugins: [],
}
// This file is used to configure Tailwind CSS, a utility-first CSS framework. It specifies the files where Tailwind should look for class names to generate styles.
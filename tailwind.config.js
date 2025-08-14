const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  content: [
    './app/**/*.html*',
    './app/**/*.vue',
    './app/packs/**/*.scss',
    './app/packs/**/*.css'
  ],
  important: true,
  theme: {
    extend: {
      screens: {
        xxl: '1920px',
        xl: {
          max: '1439px'
        },
        lg: {
          max: '1279px'
        },
        md: {
          max: '1023px'
        },
        sm: {
          max: '767px'
        }
        // sm: '640px',
        // md: '768px',
        // lg: '1024px',
        // xl: '1280px',
        // '2xl': '1536px',
      },
      colors: {
        primary: '#4479b6',
        secondary: '#8bb03e',
        tertiary: '#1d4481',
        system: {
          textgray: {
            1: '#FAFAFA',
            2: '#BDBDBD',
            3: '#616161',
            4: '#424242',
            5: '#212121'
          },
          gray: {
            1: '#cbc7cb',
            2: '#9b939b',
            3: '#6e6773',
            4: '#4a4252',
            5: '#1e263a'
          },
          indigo: {
            1: '#dedee8',
            2: '#bcbdd1',
            3: '#9a9dba',
            4: '#7780a5',
            5: '#526592',
            8: '#1e263a'
          },
          orange: {
            1: '#f8e5d2',
            2: '#f1c9a2',
            3: '#e8ab74',
            4: '#e28f48',
            5: '#da741f'
          },
          yellow: {
            1: '#fcf8eb',
            2: '#f7eed4',
            3: '#f3e4bd',
            4: '#eedaa3',
            5: '#ead08b'
          }
        }
      },
      inset: {
        0: 0,
        '1/2': '50%',
        '-05': '-1rem'
      },
      fontSize: {
        '1vw': '1vw',
        '1.5vw': '1.5vw',
        '2vw': '2vw',
        '2.5vw': '2.5vw'
      },
      height: {
        screenContent: 'calc(100vh - 6.5vw)'
      },
      minHeight: {
        screenContent: 'calc(100vh - 6.5vw)'
      },
      backgroundOpacity: {
        10: '0.1',
        20: '0.2',
        95: '0.95'
      }
    }
  },
  plugins: []
}

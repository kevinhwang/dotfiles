module.exports.onWindow = browserWindow => browserWindow.setVibrancy('dark');

const backgroundColorTransparent = 'rgba(31, 35, 41, .8)'
const backgroundColor = '#282c34'
const foregroundColor = '#abb2bf'
const cursorColor = foregroundColor
const borderColor = backgroundColor

const colors = {
  black       : backgroundColor,
  red         : '#e06c75', // red
  green       : '#98c379', // green
  yellow      : '#d19a66', // yellow
  blue        : '#56b6c2', // blue
  magenta     : '#c678dd', // pink
  cyan        : '#56b6c2', // cyan
  white       : '#d0d0d0', // light gray
  lightBlack  : '#808080', // medium gray
  lightRed    : '#e06c75', // red
  lightGreen  : '#98c379', // green
  lightYellow : '#d19a66', // yellow
  lightBlue   : '#56b6c2', // blue
  lightMagenta: '#c678dd', // pink
  lightCyan   : '#56b6c2', // cyan
  colorCubes  : '#ffffff', // white
  grayscale   : foregroundColor
}

exports.decorateConfig = config => {
  return Object.assign({}, config, {
    foregroundColor,
    backgroundColorTransparent,
    borderColor,
    cursorColor,
    colors,
    termCSS: `
      ${config.termCSS || ''}
      .cursor-node {
        mix-blend-mode: difference;
        border-left-width: 2px;
      }
    `,
    css: `
		${config.css || ''}
		.hyper_main {
		  border: none !important;
		}
		.tab_tab {
		  border: none;
        },
        .tabs_borderShim .borderShim_nfs {
          border: none;
        }
	`,
    cursorShape: 'BEAM',
    cursorColor: 'rgba(248,28,229,0.8)'
  })
}

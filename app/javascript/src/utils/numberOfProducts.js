const MOBILE_WIDTH = 650;
const TABLET_WIDTH = 1000;

const MOBILE_REQUEST_NUMBER = 6;
const TABLET_REQUEST_NUMBER = 10;
const DESKTOP_REQUEST_NUMBER = 15;

function numberOfProducts() {
  if (window.innerWidth <= MOBILE_WIDTH) {
    return MOBILE_REQUEST_NUMBER;
  } else if (window.innerWidth > TABLET_WIDTH) {
    return DESKTOP_REQUEST_NUMBER;
  }

  return TABLET_REQUEST_NUMBER;
}

export default numberOfProducts;

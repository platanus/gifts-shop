function priceToSigns(value) {
  if (value < 10000) {
    return '$';
  } else if (value < 15000) {
    return '$$';
  }

  return '$$$';
}

export default priceToSigns;

function validateEmail(email) {
  const valueRegex = new RegExp(/\S+@\S+\.\S+/);

  return valueRegex.test(email);
}

export default validateEmail;

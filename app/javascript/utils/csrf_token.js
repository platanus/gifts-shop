
export default function get() {
  const el = document.querySelector('meta[name="csrf-token"]');

  return el ? el.getAttribute('content') : '';
}

// creates a sticky button which scrolls the page to the item content
function addScrollHelper() {
  // Create the floating button
  const button = document.createElement('button');

  // Style the button
  button.style.position = 'fixed';
  button.style.bottom = '20px';
  button.style.right = '20px';
  button.style.backgroundColor = '#007BFF';
  button.style.color = 'white';
  button.style.border = 'none';
  button.style.borderRadius = '50%';
  button.style.width = '60px';
  button.style.height = '60px';
  button.style.fontSize = '18px';
  button.style.cursor = 'pointer';
  button.style.boxShadow = '0px 4px 6px rgba(0, 0, 0, 0.2)';
  button.textContent = '↓';

  // Add click event listener to scroll to the target element
  button.addEventListener('click', () => {
    const targetElement = document.querySelector('.normal_reserve_item_name');
    if (targetElement) {
      targetElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
      alert('Target element not found!');
    }
  });

  // Append the button to the body
  document.body.appendChild(button);
}

window.addEventListener("load", () => {
  addScrollHelper();
})

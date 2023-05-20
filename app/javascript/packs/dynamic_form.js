document.addEventListener('DOMContentLoaded', () => {
  const addPersonButton = document.getElementById('add-person');
  const personsContainer = document.getElementById('persons');
  let index = 0;

  
  addPersonButton.addEventListener('click', (event) => {
    event.preventDefault();
    const newPersonField = document.createElement('div');
    newPersonField.innerHTML = generatePersonField(index);
    personsContainer.appendChild(newPersonField);
    index++;
  });

  personsContainer.addEventListener('click', function(event) {
    const removeButton = event.target.closest('.remove-person');
    if (removeButton) {
      event.preventDefault();
      const personFields = removeButton.parentNode;
      const destroyInput = personFields.querySelector('input[name$="[_destroy]"]');
      if (destroyInput) {
        destroyInput.value = 'true';
      }
      personFields.remove();
    }
  });

  function generatePersonField(index) {
    return `
      <div class="person-fields", index=${index}>
        <input type="number" name="persons[][age_of_death]" placeholder="Age of Death">
        <input type="number" name="persons[][year_of_death]" placeholder="Year of Death">
        <button type="button" class="btn btn-danger remove-person">Remove Person</button>
      </div>
    `;
  }
});
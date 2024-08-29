customCloseModal = function(modalId) {
  // Obtiene el elemento de la modal
  let modal = document.getElementById(modalId);

  // Remueve la clase 'show' del elemento de la modal
  modal.classList.remove('show');

  // Elimina el atributo 'aria-modal' del elemento
  modal.removeAttribute('aria-modal');

  // Restablece el atributo 'aria-hidden' en 'true'
  modal.setAttribute('aria-hidden', 'true');
  modal.style.display = 'none';

  // Oculta el backdrop (fondo oscuro detrás de la modal)
  let backdrop = document.getElementsByClassName('modal-backdrop')[0];

  if(backdrop) {
  	backdrop.parentNode.removeChild(backdrop);
  }
}


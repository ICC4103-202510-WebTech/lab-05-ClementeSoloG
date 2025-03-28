console.log("hola");

const alertPlaceholder = document.getElementById('liveAlertPlaceholder');
const appendAlert = (message, type) => {
  const wrapper = document.createElement('div');
  wrapper.innerHTML = [
    `<div class="alert alert-${type} alert-dismissible" role="alert">`,
    `   <div>${message}</div>`,
    '   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>',
    '</div>'
  ].join('');

  alertPlaceholder.append(wrapper);
};

const alertTrigger = document.getElementById('btnAlertContact');
if (alertTrigger) {
  alertTrigger.addEventListener('click', () => {
    appendAlert('Thank you for your message, we will contact you soon.', 'success');
  });
}

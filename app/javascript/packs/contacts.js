$(document).on('turbolinks:load',function(){
  const searchInput = document.getElementById('search-input');
  $('#search-input').on('keyup', function() {
    const searchForm = document.getElementById('search-form');
    const searchValue = searchInput.value;

    fetch(`${searchForm.action}?q=${searchValue}`, {
      method: searchForm.method,
    })
      .then(response => response.text())
      .then(html => {
          const contactList = document.getElementById('contact-list');
          contactList.innerHTML = html;
      })
      .catch(error => {
          console.error('Error:', error);
      });
  });
});

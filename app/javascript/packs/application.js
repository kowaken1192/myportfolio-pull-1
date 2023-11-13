import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "./users"
import "./service"
import "./map"

document.addEventListener('turbolinks:load', () => {

  // Navbar burgers toggling
  const navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  if (navbarBurgers.length > 0) {
    navbarBurgers.forEach(el => {
      el.addEventListener('click', () => {
        const target = el.dataset.target;
        const targetElement = document.getElementById(target);
        el.classList.toggle('is-active');
        targetElement.classList.toggle('is-active');
      });
    });
  }

  // Navbar link behavior for wider screens
  const navbarLink = document.querySelector('.navbar-link');
  navbarLink.addEventListener('click', (event) => {
    if (window.innerWidth >= 465) {
      event.preventDefault();
      event.stopPropagation();
    }
  });

  // Close navbar menu on page transition
  const closeNavbarMenu = () => {
    const activeBurgers = document.querySelectorAll('.navbar-burger.is-active');
    activeBurgers.forEach(burger => {
      const target = burger.dataset.target;
      const targetElement = document.getElementById(target);
      burger.classList.remove('is-active');
      targetElement.classList.remove('is-active');
    });
  }

  window.addEventListener('beforeunload', closeNavbarMenu);
  document.addEventListener('turbolinks:before-render', closeNavbarMenu);
});

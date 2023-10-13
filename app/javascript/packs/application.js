// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "./search.post"

document.addEventListener('DOMContentLoaded', () => {
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
});

document.addEventListener('DOMContentLoaded', () => {
  const navbarLink = document.querySelector('.navbar-link');
  
  navbarLink.addEventListener('click', (event) => {
    if (window.innerWidth <= 1023) { 
      event.preventDefault(); // イベントのデフォルトの動作を停止
      event.stopPropagation(); // イベントの伝播を停止
    }
  });
});

function redirectToMapPage() {
    window.location.href = "/map/index";
  }

  document.addEventListener("DOMContentLoaded", function() {
    let savedAddress = getCookie("selectedAddress");
    let savedCountry = getCookie("selectedCountry");
    let inputPlace = getCookie("inputPlace");
  
    if (savedAddress) {
      savedAddress = removeLeadingPunctuation(decodeURIComponent(savedAddress));
      document.getElementById("post_address").value = savedAddress;
    }
  
    if (savedCountry) {
      savedCountry = removeLeadingPunctuation(decodeURIComponent(savedCountry));
      document.getElementById("post_country").value = savedCountry;
    }
  
    if (inputPlace) {
      inputPlace = removeLeadingPunctuation(decodeURIComponent(inputPlace));
      document.getElementById("post_name").value = inputPlace;
    }
  });
  
  function removeLeadingPunctuation(string) {
    if (!string) return string;
    while (string.startsWith('、')) {
      string = string.substring(1);
    }
    return string;
  }
  
  function getCookie(name) {
    let value = "; " + document.cookie;
    let parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
  }
  
  document.addEventListener('DOMContentLoaded', () => {
      (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
        const $notification = $delete.parentNode;
    
        $delete.addEventListener('click', () => {
          $notification.parentNode.removeChild($notification);
        });
      });
  });
  
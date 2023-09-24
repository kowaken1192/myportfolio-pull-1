function redirectToMapPage() {
    window.location.href = "/map/index";
  }

  document.addEventListener("DOMContentLoaded", function() {
  let savedAddress = getCookie("selectedAddress");
  let savedCountry = getCookie("selectedCountry");
  let inputPlace = getCookie("inputPlace");

  if (savedAddress) {
    document.getElementById("post_address").value = decodeURIComponent(savedAddress);
  }

  if (savedCountry) {
    document.getElementById("post_country").value = decodeURIComponent(savedCountry);
  }

  if (inputPlace) {
    document.getElementById("post_name").value = decodeURIComponent(inputPlace);
  }
});
  function getCookie(name) {
    let value = "; " + document.cookie;
    let parts = value.split("; " + name + "=");
    if (parts.length == 2) return parts.pop().split(";").shift();
  }

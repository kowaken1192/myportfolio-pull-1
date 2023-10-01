document.addEventListener("DOMContentLoaded", function() {
  let savedAddress = getCookie("selectedAddress");
  let savedCountry = getCookie("selectedCountry");
  let inputPlace = getCookie("inputPlace");
  let savedPrefecture = getCookie("selectedPrefecture");

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

  if (savedPrefecture) {
    savedPrefecture = removeLeadingPunctuation(decodeURIComponent(savedPrefecture));
    document.getElementById("post_prefecture").value = savedPrefecture; // あなたの都道府県のinput要素のIDに合わせてください
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

function redirectToMapPage() {
  window.location.href = "/map/index";
}

document.addEventListener('DOMContentLoaded', () => {
  (document.querySelectorAll('.notification .delete') || []).forEach(($delete) => {
    const $notification = $delete.parentNode;

    $delete.addEventListener('click', () => {
      $notification.parentNode.removeChild($notification);
    });
  });
});
